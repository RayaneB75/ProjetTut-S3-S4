#!/bin/bash

# Créer un utilisateur avec mot de passe --> à utiliser pour php
[[ $# -ne 1 ]] && echo "Nombre d'argument incorrect : il faut donner le nom de l'utilisateur"
[[ $# -ne 1 ]] && echo "Format de la commande : \e[31m $ \e[32m ./gen_user.sh \e[35m [NOM_DE_L'UTILISATEUR]"

echo "Creation "
export CLIENTNAME="$1"
docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME

# Récupérer son fichier
docker-compose run --rm openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn

# Revoquer un certificat client en supprimant le fichier crt, la clé et le fichier req.
[[ $2 == "-d" ]] && docker-compose run --rm openvpn ovpn_revokeclient $CLIENTNAME remove

# Initialiser les fichiers de configuration et les certificats
sudo docker run -d --name openvpn -v ~/openvpn/data:/etc/openvpn --log-driver=none \
--rm kylemanna/openvpn ovpn_genconfig -u udp://vpn.rayane.space

docker-compose run --rm openvpn ovpn_initpki

# Au cas où il y aurait des problèmes de droits
sudo chown -R $(whoami): ./openvpn-data