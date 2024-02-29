import os
from git import Repo
from datetime import datetime
import subprocess
import mysql.connector
import json
import difflib


class diffDatabase():
    def __init__(self):
        self.name_files = None
        self.conn = None
        self.diff_result = None
        self.ddl = None
        self.last_schema = None
        self.current_schema = None

    def db_connection(self, database, username, password, host, port):
        conn = mysql.connector.connect(database=database, user=username,
                                       password=password, host=host, port=port)
        self.conn = conn
        return self.conn

    def checking_git(self, path):
        files = os.listdir(path=path)
        self.name_files = sorted(files, reverse=True)
        return self.name_files

    def maria_db_dump(self, host, user, password, database, path_backup):
        timestr = datetime.now().strftime('%Y%m%d-%H%M%S')
        filename = '{}-{}.sql'.format(timestr, database)
        local_file_path = '{}{}'.format(path_backup, filename)
        command = [
            'mysqldump',
            '-h', host,
            '-u', user,
            '-p' + password,
            database
        ]

        with open(local_file_path, 'w') as f:
            subprocess.run(command, stdout=f)

        repo = Repo(os.getcwd())
        file_path = os.path.join(path_backup, filename)
        repo.git.add(file_path)
        repo.git.commit('-m', f"add Backup")

    def delete_file_git(self, path):
        repo = Repo(os.getcwd())
        for file_to_remove in self.name_files[2:]:
            file_path = os.path.join(path, file_to_remove)
            os.remove(file_path)
            repo.git.add(file_path)
            repo.git.commit('-m', f"Remove {file_to_remove}")
            origin = repo.remote(name='origin')
            origin.push('main')

    def get_current_schema(self, path_skema):
        try:
            cur = self.conn.cursor(dictionary=True)
            cur.execute("""
                    SELECT table_schema, table_name, column_name, data_type, ordinal_position
                    FROM information_schema.columns
                    WHERE table_schema NOT IN ('information_schema', 'mysql', 'performance_schema', 'sys')
                    ORDER BY table_schema, table_name, ordinal_position;
                """)
            schema = cur.fetchall()
            timestr = datetime.now().strftime('%Y%m%d-%H%M%S')
            os.makedirs(path_skema, exist_ok=True)
            output_file = os.path.join(path_skema, f'{timestr}-skema.json')
            with open(output_file, 'w') as file:
                json.dump(schema, file)

            repo = Repo(os.getcwd())
            file_path = os.path.join(path_skema, f'{timestr}-skema.json')
            repo.git.add(file_path)
            repo.git.commit('-m', f"add Backup")

        except Exception as e:
            print("Error fetching schema:", e)
            return None

    def diff_content(self, path_backup):
        '''
        Function to detect and collected what's diff from two schemas
        '''
        files = os.listdir(path_backup)
        self.name_files = sorted(files, reverse=True)
        output_file1 = ''.join([path_backup, self.name_files[0]])
        output_file2 = ''.join([path_backup, self.name_files[1]])
        print(f'List backup: {output_file1, output_file2}')

        with open(output_file2, 'r') as file1, open(output_file1, 'r') as file2:
            file1_lines = file1.readlines()
            file2_lines = file2.readlines()

        diff = difflib.unified_diff(
            file1_lines, file2_lines, output_file1, output_file2)
        collected_lines = []
        
        for line in diff:
            if not line.startswith(('---', '/*', '+++', '@@', '--', ' --', ' ', '+--', '-', '+COPY', '+\\.', 'LOCK', 'UNLOCK')):
                if line.startswith('+'):
                    line_content = line[1:].strip()
                    if not line_content.startswith(('/*', 'LOCK', 'UNLOCK', 'DROP')):
                        collected_lines.append(line_content)
                else:
                    line_content = line.strip()
                    if line_content and not line_content.startswith(('-', '/*', 'LOCK', 'UNLOCK', 'DROP')):
                        collected_lines.append(line_content)
        statement = ""
        clean_sql = []
        
        for line in collected_lines:
            statement += line + " "
            if line.endswith(';'):
                clean_sql.append(statement)
                statement = ""
        diff_result = set(clean_sql)
        return diff_result


    def generate_ddl_for_changes(self, path_skema, path_backup):
        '''
        Function to create ddl file migration
        '''
        ddl_statements = []
        json_file_current = ''.join([path_skema, self.name_files[0]])
        json_file_last = ''.join([path_skema, self.name_files[1]])

        with open(json_file_last, 'r') as f:
            self.last_schema = json.load(f)

        with open(json_file_current, 'r') as f:
            self.current_schema = json.load(f)

        last_columns = {(row['table_schema'], row['table_name'],
                         row['column_name']): row for row in self.last_schema}
        current_columns = {(row['table_schema'], row['table_name'],
                            row['column_name']): row for row in self.current_schema}

        # DETECT NEW TABLE & ALTER ADD COLUMN
        for column_key in current_columns.keys():
            if column_key not in last_columns:
                column = current_columns[column_key]

                diff_result = self.diff_content(path_backup)
                print(f'DIFF: \n {diff_result}')
                contains_create = any("create" in string.lower()
                                      for string in diff_result)
                contains_table = any(
                    "{column['table_name']}" in string.lower() for string in diff_result)

                print(
                    f"contain_create: {contains_create}  |  contain_table: {contains_table}")
                print(diff_result)

                try:
                    if contains_create == True:
                        for line in diff_result:
                            ddl_statements.append(line)

                    else:
                        ddl = f"ALTER TABLE {column['table_schema']}.{column['table_name']} ADD COLUMN {column['column_name']} {column['data_type']};"
                        ddl_statements.append(ddl)

                except:
                    print(
                        'ERROR create migration file for create/alter table or new column')

        # DETECT DROP TABLE AND ALTER DROP COLUMN
        for column_key in last_columns.keys():
            if column_key not in current_columns:

                try:
                    column = last_columns[column_key]
                    column_table_name = column['table_name']
                    cursor = self.conn.cursor()
                    cursor.execute(
                        f"SELECT * FROM information_schema.columns WHERE table_name = '{column_table_name}'")
                    columns = cursor.fetchall()
                    table_lenght = len(columns)

                    if table_lenght != 0:
                        ddl = f"ALTER TABLE {column['table_schema']}.{column['table_name']} DROP COLUMN {column['column_name']};"
                        ddl_statements.append(ddl)

                    else:
                        ddl = f"DROP TABLE {column['table_schema']}.{column['table_name']};"
                        ddl_statements.append(ddl)

                except:
                    print('ERROR create migration file for detect DROP columns/table')
        self.ddl = set(ddl_statements)
        return self.ddl

    def changes_query(self, path_bytebase, DB_NAME):
        current_time = datetime.now().strftime("%Y%m%d%H%M%S")
        migration_file_name = f"{DB_NAME}##{current_time}##ddl#update_schema.sql"
        migration_outfile = ''.join([path_bytebase, migration_file_name])

        if self.current_schema != self.last_schema:
            print(f"[{current_time}] Schema change detected!")

            ddl_statements = self.ddl

            with open(migration_outfile, "a") as migration_file:
                for ddl in ddl_statements:
                    migration_file.write(ddl + "\n")

            repo = Repo(os.getcwd())
            file_path = os.path.join(path_bytebase, migration_file_name)
            repo.git.add(file_path)
            repo.git.commit('-m', f"add Backup")
        else:
            print(f"[{current_time}] Schema not changed.")


def main():
    print('Only MariaDb detection changes')


if __name__ == "__main__":
    main()
