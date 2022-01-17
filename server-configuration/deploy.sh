#!/bin/bash

# Permet d'intégrer les alias dans les scripts
shopt -s expand_aliases 
alias echo="echo -e"

# Function installation de paquetage
function getApp() {
	echo "##########################################"
	echo "\e[4m Installation du paquetage $1 \e[0m \n"
	sudo apt install $1 -y
	[[ $? -ne 0 ]] && echo "\e[31m Erreur. \e[0m \e[4m Vérifier l'installation du paquetage $1 \e[0m"
	echo "\nInstallation de $1\e[32m OK \e[0m"
	echo "##########################################\n"
	done
}

# Function de récupération des container backupés
function getBack() {
	echo "\e[4m Répertoire de sauvegarde des container \e[0m"
	read rep
	echo "##########################################"
	echo "\e[4m Récupération du container $1 \e[0m\n "
	docker load -i $rep/backup-$1
	echo "##########################################"
}

# On vérifie que le script est bien execute en root (sudo)
function getAdmin() {
	[[ $EUID -ne 0 ]] && echo "Le script doit être lancé en\e[31m root\e[0m:\e[32m \$sudo <script> \e[0m" && exit 1
	echo "\e[4m Lancement du script de déploiement \e[0m"
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
	echo "\e[4m Récupération des paquetages nécessaires \e[0m \n"
	echo "##########################################"
	echo "\e[4m Mise à jour des repository : \e[0m"
	sudo apt update
	[[ $? -ne 0 ]] && echo "##########################################" && echo "\e[31m Erreur. \e[0m \e[4m Vérifier la connexion réseau \e[0m" && exit 1
	echo "##########################################"
	echo "\nRepositories\e[32m OK \e[0m"
}

# ----------- main ----------- #

# On vérifie qu'on est bien en root
getAdmin
mkdir -p /volume1/docker/rayane/docker-data/dms/mail-logs/
mkdir -p /volume1/docker/rayane/docker-data/dms/mail-state/
mkdir -p /volume1/docker/rayane/docker-data/dms/mail-data/
mkdir -p /volume1/docker/rayane/docker-data/dms/config/
mkdir -p /volume1/docker/rayane/www
mkdir -p /volume1/docker/rayane/openvpn/data
mkdir -p /volume1/docker/rayane/portainer
mkdir -p /volume1/docker/rayane/shared
mkdir -p /volume1/docker/rayane/docker-data/secrets/

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

echo "\e[4m Chemin d'accès du fichier \e[32m docker-compose \e[0m ?"
read fic
echo "\e[32m On démarre les container docker \e[0m"
sudo docker-compose up -d $fic