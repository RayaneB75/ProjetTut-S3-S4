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
		<link rel="stylesheet" href="../style.css" />
		<title> Page d'accueil </title>
	</head>
	<body>
		<div class="success">
		<h1>Bienvenue <?php echo $_SESSION['username']; ?> !</h1>
		<p>C'est votre espace administrateur, merci de placer vos fichier DICOM ici.</p>
		<p>Pour accéder aux dossiers médicaux électroniques <a href=https://emr.rayane.space/openemr> cliquez ici </a></p>
		</br>
		<iframe title="dicomViewer" width="1280" height="720" src="https://dicom.rayane.space/">
		</br>
		<a href="add_user.php">Add user</a> | 
		<a href="#">Update user</a> | 
		<a href="#">Delete user</a> |
		<a href="../logout.php">Déconnexion</a>
		</div>
	</body>
</html>