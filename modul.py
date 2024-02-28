import os
from git import Repo
from datetime import datetime
import subprocess
import mysql.connector
import json
import difflib
import sys


class diffDatabase():
    def __init__(self):
        self.name_files = None
        self.conn = None

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
        # Construct the mysqldump command
        command = [
            'mysqldump',
            '-h', host,
            '-u', user,
            '-p' + password,
            database
        ]

        # Execute the mysqldump command
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
        files = os.listdir(path_backup)
        self.name_files = sorted(files, reverse=True)
        output_file1 = os.path.join(path_backup, self.name_files[0])
        output_file2 = os.path.join(path_backup, self.name_files[1])
        with open(output_file2, 'r') as file1, open(output_file1, 'r') as file2:
            file1_lines = file1.readlines()
            file2_lines = file2.readlines()

        diff = difflib.unified_diff(
            file1_lines, file2_lines, output_file1, output_file2)
        collected_lines = []  # Daftar untuk mengumpulkan baris yang telah diproses
        for line in diff:
            if not line.startswith(('---', '/*', '+++', '@@', '--', ' --', ' ', '+--', '-', '+COPY', '+\\.', 'LOCK', 'UNLOCK')):
                if line.startswith('+'):
                    line_content = line[1:].strip()
                    if not line_content.startswith(('/*', 'LOCK', 'UNLOCK', 'DROP')):
                        collected_lines.append(line_content)
                else:
                    line_content = line.strip()  # Hapus whitespace di awal dan akhir baris
                    if line_content and not line_content.startswith(('-', '/*', 'LOCK', 'UNLOCK', 'DROP')):
                        collected_lines.append(line_content)
        statement = ""
        clean_sql = []
        for line in collected_lines:
            statement += line + " "
            if line.endswith(';'):
                # print(statement)
                clean_sql.append(statement)
                statement = ""
        return set(clean_sql)


def main():
    path_backup = 'backup/'
    path_skema = 'skema/'
    path_bytebase = 'bytebase/develop/'

    DB_NAME = 'demodb'
    DB_USER = 'divistant'
    DB_PASS = 'divistant@2024'
    DB_HOST = '103.117.56.81'
    DB_PORT = '3306'

    db = diffDatabase()
    db.db_connection(DB_NAME, DB_USER, DB_PASS, DB_HOST, DB_PORT)
    db.checking_git(path_backup)
    count_files = len(db.name_files)
    if count_files == 0:
        db.maria_db_dump(DB_HOST, DB_USER, DB_PASS, DB_NAME, path_backup)

    elif count_files == 1:
        db.maria_db_dump(DB_HOST, DB_USER, DB_PASS, DB_NAME, path_backup)
        print('data berjumlah 1')
        db.get_current_schema(path_skema)
        db.checking_git(path_skema)
        if len(db.name_files) > 2:
            db.delete_file_git(path_skema)

    elif count_files >= 2:
        db.maria_db_dump(DB_HOST, DB_USER, DB_PASS, DB_NAME, path_backup)
        print('data berjumlah lebih dari sama dengan 2')
        db.checking_git(path_backup)
        db.delete_file_git(path_backup)
        db.get_current_schema(path_skema)
        db.checking_git(path_skema)
        if len(db.name_files) > 2:
            db.delete_file_git(path_skema)


if __name__ == "__main__":
    main()
