#!/bin/bash

# Créer un utilisateur avec mot de passe
export CLIENTNAME="your_client_name"
docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME

# Récupérer son fichier
docker-compose run --rm openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn

# Revoquer un certificat client en supprimant le fichier crt, la clé et le fichier req.
docker-compose run --rm openvpn ovpn_revokeclient $CLIENTNAME remove

# Initialiser les fichiers de configuratoin et les certificats
sudo docker run -d --name openvpn -v ~/openvpn/data:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_genconfig -u udp://vpn.rayane.space
docker-compose run --rm openvpn ovpn_initpki

# Au cas où il y aurait des problèmes de droits
sudo chown -R $(whoami): ./openvpn-data