import os
import requests

url_base = "http://localhost:8080/.hidden/"
# Liste les fichiers à télécharger
filenames = [
    "README",
    "file1.txt",  # Remplacer par les vrais noms de fichiers que tu vois dans la liste
    "file2.log",  # ...
    # Ajoute ici d'autres fichiers que tu vois dans le dossier
]

for filename in filenames:
    file_url = url_base + filename
    response = requests.get(file_url)

    if response.status_code == 200:
        print(f"Contenu de {filename} :\n")
        print(response.text)
        print("\n" + "="*50 + "\n")
    else:
        print(f"Impossible de récupérer {filename}")
