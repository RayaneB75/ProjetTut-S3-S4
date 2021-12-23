#!/bin/bash
# Script pour déployer les VM sur un PC linux quelconque
[[ $EUID -ne 0 ]] && echo "Le script doit être lancé en root: #sudo <script>" && exit 1
echo "Lancement du script de déploiement"

# Si un répertoire "projettut" n'existe pas on le crée
[[ ! -d projettut ]] && mkdir projettut && [[ $? -ne 0 ]] && echo "Vérifier les droits d'accès de ce répertoire pour l'utilisateur $USER" && exit 1
chmod 777 projettut
cd projettut # On rentre dans le répertoire

# On met à jour les repositories
echo "---------------------------------------------------------"
echo -e "Récupération des paquetages nécessaires\n"
echo "##########################################"
echo "Mise à jour des repository :"
sudo apt update
[[ $? -ne 0 ]] && echo "##########################################" && echo "Erreur. Vérifier la connexion réseau" && exit 1
echo -e "##########################################"
echo -e "\nRepositories OK"

# Installation des paquetages 1 par 1
for i in curl docker-ce docker-ce-cli software-properties-common containerd.io
do
    [[ $i -eq "containerd" ]] && 
    echo -e "Installation du paquetage $i \n"
    echo "##########################################"
    sudo apt install $i -y
    [[ $? -ne 0 ]] && echo "Erreur. Vérifier l'installation du paquetage $i" && continue
    echo "##########################################"
    echo -e "\nInstallation de $i OK"
done

echo "---------------------------------------------------------"