from modul import diffDatabase

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
    
    if count_files >= 2:
        db.checking_git(path_backup)
        db.delete_file_git(path_backup)
    db.get_current_schema(path_skema)
    db.checking_git(path_skema)

    if len(db.name_files) > 2:
        db.delete_file_git(path_skema)
    db.diff_content(path_backup)
    db.checking_git(path_skema)
    db.generate_ddl_for_changes(path_skema)
    db.changes_query(path_bytebase, DB_NAME)
