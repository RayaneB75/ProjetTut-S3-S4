#!/bin/bash

# Variables globales
shopt -s expand_aliases # Permet d'intégrer les alias dans les scripts
alias echo="echo -e"
rouge="\e[31m"
rien="\e[0m"
vert="\e[32m"
ul="\e[4m"

# Function installation de paquetage 1 par 1
function getApp() {
	echo "##########################################"
	echo "$ul Installation du paquetage $1 $rien \n"
	sudo apt install $1 -y
	[[ $? -ne 0 ]] && echo "$rouge Erreur. $rien $ul Vérifier l'installation du paquetage $1 $rien"
	echo "\nInstallation de $1$vert OK $rien"
	echo "##########################################\n"
	done
}

# Function de récupération des container backupé
function getBack() {
	echo "$ul Répertoire de sauvegarde des container $rien"
	read rep
	echo "##########################################"
	echo "$ul Récupération du container $1 $rien\n "
	docker load -i $rep/backup-$1
	echo "##########################################"
}

# On vérifie que le script est bien execute en root (sudo)
function getAdmin() {
	[[ $EUID -ne 0 ]] && echo "Le script doit être lancé en$rouge root$rien:$vert \$sudo <script> $rien" && exit 1
	echo "$ul Lancement du script de déploiement $rien"
}

# Récupération du repository docker
function getRepo {
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo \
		"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
		$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
}

# Mise à jour repositories
function updateRepo {
	echo "---------------------------------------------------------"
	echo "$ul Récupération des paquetages nécessaires $rien \n"
	echo "##########################################"
	echo "$ul Mise à jour des repository : $rien"
	sudo apt update
	[[ $? -ne 0 ]] && echo "##########################################" && echo "$rouge Erreur. $rien $ul Vérifier la connexion réseau $rien" && exit 1
	echo "##########################################"
	echo "\nRepositories$vert OK $rien"
}





# ----------- main ----------- #
mkdir -p /volume1/docker/rayane/projet-tut/www
mkdir -p /volume1/docker/rayane/openvpn/data
mkdir -p /volume1/docker/projet-tutore/portainer
mkdir -p /volume1/docker/projet-tutore/shared

[[ ! -d projettut ]] && mkdir projettut && [[ $? -ne 0 ]] && echo "$ul\Vérifier les droits d'accès de ce répertoire pour l'utilisateur$rouge $USER$rouge$ul" && exit 1
chmod 777 projettut
cd projettut # On rentre dans le répertoire

# On vérifie qu'on est bien en root
getAdmin
# Mise à jour des repositories
updateRepo
# Installation des paquetages système (pour rajouter les repositories)
getApp "ca-certificates" ; getApp 'curl' ; getApp 'gnupg lsb-release'
# On récupère les repositories nécessaires
getRepo
# Mise à jour des nouveaux repositories
updateRepo
# Installation des paquetages pour la maquette
getApp "docker-ce" ; getApp "docker-ce-cli" ; getApp "containerd.io"
# Récupération des container
getBack "ns" ; getBack "www" ; getBack "portainer" ; getBack "openvpn"

echo "$ul Où se situe le fichier docker-compose$rien"
read fic
echo "$vert On démarre les container docker $rien"
docker-compose up -d $fic