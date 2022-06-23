<?php
	// Initialiser la session
	session_start();
	// Vérifiez si l'utilisateur est connecté, sinon redirigez-le vers la page de connexion
	if(!isset($_SESSION["username"])){
		header("Location: login.php");
		exit(); 
	}
?>






<!DOCTYPE html>
<html>
	<head>
	    
		<link rel="stylesheet" href="style.css" />
		<title> Page d'accueil </title>
	</head>
	<body>
		
		
		<div class="success">

		<h1>Bienvenue docteur <?php echo $_SESSION['username']; ?> !</h1>
		<p>C'est votre espace utilisateur, vous pouvez visualiser vos fichier DICOM ici.</p>
		<p>Pour accéder aux dossiers médicaux électroniques <a href=https://emr.rayane.space/openemr> cliquez ici </a></p>
		</br>
		<iframe title="dicomViewer" width="1280" height="720" src="https://dicom.rayane.space/">
		</iframe>
		</br>
		<a href="logout.php">Déconnexion</a>
        <button id="Déconnexion">Déconnexion</button>
				
					<!--Début du code pour le bouton vers la page de personnalisation de profile.-->
					<p>Pour acceder à votre espace personnel veuiller cliquer sur le bouton ci-dessous.</p>
			<bouton onclick="windows.location.href='www\Programme_Jassem\profile.html';">Espace personnel</bouton>
					<style>
					button {
						display: inline-block;
						background-color: #7b38d8;
						border-radius: 10px;
						border: 4px double #cccccc;
						color: #eeeeee;
						text-align: center;
						font-size: 28px;
						padding: 20px;
						width: 200px;
						transition: all 0.5s;
						cursor: pointer;
						margin: 5px;
					}
					button span {
						cursor: pointer;
						display: inline-block;
						position: relative;
						transition: 0.5s;
					}
					button span:after {
						content: "\00bb";
						position: absolute;
						opacity: 0;
						top: 0;
						right: -20px;
						transition: 0.5s;
					}
					button:hover {
						background-color: #f7c2f9;
					}
					button:hover span {
						padding-right: 25px;
					}
					button:hover span:after {
						opacity: 1;
						right: 0;
					}
				</style>
<!--Fin du code pour le bouton vers la page de personnalisation de profile.-->
		</div>
	<body>
<html>

