# Projet Tutoré S3-S4

## Abdallah
**Coté Front-end** :
- Interface personnel hospitalier 
	- Menu personnalisé
		- Profil
		- Dicom Viewer
		- Paramètres
	- Ajout/Modifications informations patients
	- Transfert vers un praticien
	- Pour les images Dicom
		- Lecteur des enregistrement
		- Prise de note pour la retranscription 
		- Anonymisation des informations —> Récupération du nom/prénom/âge/sexe/... grâce au numéro du patient
- Animation entre les pages (UX)

## Jassem
### **Coté Front-end** :
- Interface médecin 
	- Menu personnalisé
		- Profil
		- Dicom Viewer
		- Paramètres	
	- Annotations pour les images Dicom
		- Notes écrites
		- Enregistreur
		- Retranscription automatique
	- Infos patients en cours
	- Bouton "Transfert" vers l'hôpital
	- Anonymisation des informations —> Numéro du patient / Âge du patient / Sexe
- Animations entre les pages (UX)

## Baptiste
### **Côté Back-end** :
- SQL —> Requêtes pour le front-end
	- Fonctionnalités pour les interfaces utilisateur
	- Chiffrement des informations
	- Liens avec le VPN
	- Connexion utilisateur (consultation BDD)
		- Disjonction hôpital/médecin (2 pages web)
		- Page de création de compte 
	- Ajout dans BDD
	- Cookies 
	- Utilisateur connectés
	- Monitoring du nombre d’utilisateurs connectés)
	- Dépannage de comptes : mot de passe oublié → Mail de récupération de mot de passe (authentification à deux facteurs)
### **Coté Front-end** :
- Page de contact / Support
- Formulaire interactif (menu déroulant - Exemple : https://help.twitter.com/fr/forms)
- Foire Au Questions (FAQ – Exemple : https://help.twitter.com/fr)

## Rayane : 
### **Côté Back-end** :
- Configuration des serveurs (Docker : hyperviseur de type 1)
	- Serveur DNS (Bind9)		
		- Domaine/zone principal.e (page d’accueil)
		- Sous domaine/zone (interface admin/utilisateurs)
	- Serveur VPN (OpenVPN)
		- Chiffrement
		- Base de données reliée à la base de données Web
	- Serveur SQL (MySQL, phpMyAdmin)	
		- Gestion des droits utilisateurs
		- Chiffrement TLS/SSL
	- Serveur Web (Apache2/Nginx)
		- Virtualhost (HTTP/HTTPS) et chiffrement TLS/SSL
		- Redirection HTTP vers HTTPS
		- Partage de charge
		- Reverse proxy (sous-domaine pour interfaces différentes)

### **Côté Front-end** :
- Charte graphique
- Harmonisation entre les pages de Baptiste, Jassem, Abdallah et Rayane
- Page diverses sur le site
	- Présentation de l’entreprise, de ses services, de ses prix, etc.
 	- Accueil