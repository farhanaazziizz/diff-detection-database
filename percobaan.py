from git import Repo
import os

repo = Repo(os.getcwd())

# Ambil URL remote GitLab
remote_url = repo.remotes.origin.url

# Lakukan pull dari remote GitLab
repo.remotes.origin.pull()

print("Pull selesai")
