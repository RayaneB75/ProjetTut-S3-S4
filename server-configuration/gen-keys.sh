#!/bin/sh

set -eu
command -v openssl >/dev/null 2>&1 || { 
    echo >&2 "Unable to find openssl. Please make sure openssl is installed and in your path."; exit 1; 
}
[[ ! -f openssl.cnf ]] && echo "Il faut exécuter le script depuis le répertoire /etc/openvpn/server" && exit 1

# On génère une clé statique pour tsl-auth
openvpn — genkey — secret ta.key

# On créé les répertoires et les fichiers nécessaires à l'exécution du script
# Si le fichier sample-ca/index.txt existe on le remplace
[[ ! -d sample-ca ] && mkdir -p sample-ca
[[ -f sample-ca/index.txt ] && rm -f sample-ca/index.txt
touch sample-ca/index.txt
echo "01" > sample-ca/serial

# On génère la clé CA et le certificat
openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 \
-extensions easyrsa_ca -keyout sample-ca/ca.key -out sample-ca/ca.crt \
-subj "/C=VN/ST=SAIGON/L=SAIGON/O=OpenVPN-TEST/emailAddress=vpn@test.net" \
-config openssl.cnf

# Création de clé côté serveur
openssl req -new -nodes -config openssl.cnf -extensions server \
-keyout sample-ca/server.key -out sample-ca/server.csr \
-subj "/C=VN/ST=SAIGON/O=OpenVPN-TEST/CN=VPN-Server/emailAddress=vpn@test.net"

# Création du certificat :
openssl ca -batch -config openssl.cnf -extensions server \
-out sample-ca/server.crt -in sample-ca/server.csr

# On copie les fichiers serveurs dans le répertoire d'OpenVPN pour les prendres en compte
for i in server.key server.crt ca.crt dh2048.pem
do
    cp $i /etc/openvpn 2>&1 && err=$(echo $?)
    [[ $err -ne 0 ]] && echo -e "\nErreur dans la copie du fichier $i"
done

# Paramètre DH pour la configuration du serveur OpenVPN
openssl dhparam -out dh2048.pem 2048