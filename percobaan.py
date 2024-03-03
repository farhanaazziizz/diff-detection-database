from git import Repo
import os

# Tentukan kredensial GitLab
username = "farhanaazziizz"
access_token = "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"

# Dapatkan jalur direktori kerja saat ini
current_directory = os.getcwd()

# Inisialisasi repositori
repo = Repo(current_directory)

# Dapatkan URL remote GitLab
remote_url = repo.remotes.origin.url

# Modifikasi URL remote untuk menambahkan kredensial
if username and access_token:
    modified_remote_url = f"https://{username}:{access_token}@{remote_url.split('://')[1]}"
else:
    modified_remote_url = remote_url

# Lakukan pull dari remote GitLab
file_path = os.path.join('percobaan.py')
repo.git.add(file_path)
repo.git.commit('-m', f"Remove percobaan.py ")
origin = repo.remote(name='origin')
origin.push('main')


print("Pull selesai")
