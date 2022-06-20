﻿<?php
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
		<h1>Bienvenue docteur <?php echo $_SESSION['username']; ?>!</h1>
		<p>C'est votre espace utilisateur, vous pouvez visualiser vos fichier DICOM ici.</p>
		</br>
		<iframe title="dicomViewer" width="1280" height="720" src="https://dicom.rayane.space/">
		</iframe>
		</br>
		<a href="logout.php">Déconnexion</a>
		</div>
	</body>
</html>