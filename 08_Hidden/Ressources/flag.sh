#!/bin/bash

BASE_URL="http://localhost:8080/.hidden"
QUEUE=("$BASE_URL/")  # Liste des dossiers à explorer
VISITED=()  # Pour éviter de repasser sur un même lien

while [[ ${#QUEUE[@]} -gt 0 ]]; do
    CURRENT_URL="${QUEUE[0]}"
    QUEUE=("${QUEUE[@]:1}")  # On enlève l'URL actuelle de la liste

    echo "🔎 Exploring: $CURRENT_URL"

    # Récupérer la page HTML et chercher les nouveaux liens
    LINKS=$(curl -s "$CURRENT_URL" | grep -oP '(?<=href=")[^"]+' | grep -v '^\.\.' | grep -v '^#')

    for LINK in $LINKS; do
        FULL_URL="$CURRENT_URL/$LINK"
        if [[ ! " ${VISITED[*]} " =~ " ${FULL_URL} " ]]; then
            QUEUE+=("$FULL_URL")
            VISITED+=("$FULL_URL")
        fi
    done

    # Vérifier si un fichier README existe
    README_URL="$CURRENT_URL/README"
    README_CONTENT=$(curl -s "$README_URL")

    if [[ ! -z "$README_CONTENT" ]]; then
        echo "📄 Found README: $README_URL"
        echo "$README_CONTENT"

        # Vérifier si le mot "flag" est présent dans le README
        FLAG=$(echo "$README_CONTENT" | grep -i "flag")
        if [[ ! -z "$FLAG" ]]; then
            echo "🎉 FLAG FOUND: $FLAG"
            exit 0
        fi
    fi
done

