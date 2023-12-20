#!/bin/bash

# Vérifie que le fichier CSV existe
if [ ! -f "$1" ]; then
  echo "Le fichier CSV '$1' n'existe pas."
  exit 1
fi

# Ouvre le fichier CSV en mode lecture
CSV_FILE=$(realpath "$1")
CSV_DATA=$(cat "$CSV_FILE")

# Crée une boucle pour itérer sur les lignes du fichier CSV
for line in $CSV_DATA; do
  # Sépare les données de la ligne
  SPLIT_LINE=$(echo "$line" | tr ";" " ")

  # Crée le nom d'utilisateur
  USERNAME="${SPLIT_LINE[0]}"

  # Crée le nom complet
  FULLNAME="${SPLIT_LINE[1]} ${SPLIT_LINE[2]}"

  # Crée le groupe
  GROUP="users"

  # Ajoute l'utilisateur
  adduser -m -g "$GROUP" -u "$USERNAME" -s "/bin/bash" -c "$FULLNAME" "$USERNAME"
done

# Affiche un message de succès
echo "Les utilisateurs ont été créés avec succès."
