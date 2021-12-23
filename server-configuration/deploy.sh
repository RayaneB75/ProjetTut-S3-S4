#!/bin/bash

# Variables globales
shopt -s expand_aliases
alias echo="echo -e"
rouge="\e[31m"
rien="\e[0m"
vert="\e[32m"
ul="\e[4m"

# On vérifie que le script est bien execute en root (sudo)
[[ $EUID -ne 0 ]] && echo "Le script doit être lancé en$rouge root$rien:$vert \$sudo <script> $rien" && exit 1
echo "$ul Lancement du script de déploiement $rien"

# Si un répertoire "projettut" n'existe pas on le crée
[[ ! -d projettut ]] && mkdir projettut && [[ $? -ne 0 ]] && echo "$ul\Vérifier les droits d'accès de ce répertoire pour l'utilisateur$rouge $USER$rouge$ul" && exit 1
chmod 777 projettut
cd projettut # On rentre dans le répertoire

# On met à jour les repositories
echo "---------------------------------------------------------"
echo "$ul Récupération des paquetages nécessaires $rien \n"
echo "##########################################"
echo "$ul Mise à jour des repository : $rien"
sudo apt update
[[ $? -ne 0 ]] && echo "##########################################" && echo "$rouge Erreur. $rien $ul Vérifier la connexion réseau $rien" && exit 1
echo "##########################################"
echo "\nRepositories$vert OK $rien"

# Function installation de paquetage 1 par 1
function getApp() {
    for i in $*; do
        echo "##########################################"
        echo "$ul Installation du paquetage $i\n $rien"
        sudo apt install $i -y
        [[ $? -ne 0 ]] && echo "$rouge Erreur. $rien $ul Vérifier l'installation du paquetage $i $rien" && continue
        echo "\nInstallation de $i$vert OK $rien"
        echo "##########################################\n"
    done
}

# Installation des paquetages système (pour faire la suite)
app="ca-certificates curl gnupg lsb-release"
getApp $app

# Récupération du repository docker
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Installation des paquetages pour la maquette
app="docker-ce docker-ce-cli containerd.io"
getApp $app