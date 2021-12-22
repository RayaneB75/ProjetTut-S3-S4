#!/bin/bash

#On fait un backup des containers:
if [ $1 -eq "backup"]
then
    for i in www openvpn ns portainer
    do
        echo "Backup du container $i en cours"
        sudo docker commit -p $i backup-$i
        echo "Sauvegarde dans le répertoire /var/services/homes/rayane/backup"
        sudo docker save -o /var/services/homes/rayane/backup/backup-$i.tar
    done
elif [ $1 -eq "load" ]
then
    echo "Où sont les container à récupérer"
    read var
    sudo docker load -i $var/*
fi