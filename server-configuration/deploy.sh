#!/bin/bash

# Permet d'intégrer les alias dans les scripts
shopt -s expand_aliases 
alias echo="echo -e"

# Variables globales
rouge="\e[31m"
rien="\e[0m"
vert="\e[32m"
ul="\e[4m"

# Function installation de paquetage
function getApp() {
	echo "##########################################"
	echo "$ul Installation du paquetage $1 $rien \n"
	sudo apt install $1 -y
	[[ $? -ne 0 ]] && echo "$rouge Erreur. $rien $ul Vérifier l'installation du paquetage $1 $rien"
	echo "\nInstallation de $1$vert OK $rien"
	echo "##########################################\n"
	done
}

# Function de récupération des container backupés
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

# On vérifie qu'on est bien en root
getAdmin

mkdir -p /volume1/docker/rayane/www
mkdir -p /volume1/docker/rayane/openvpn/data
mkdir -p /volume1/docker/rayane/portainer
mkdir -p /volume1/docker/rayane/shared

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

echo "$ul Chemin d'accès du fichier $vert docker-compose $rien ?"
read fic
echo "$vert On démarre les container docker $rien"
sudo docker-compose up -d $fic