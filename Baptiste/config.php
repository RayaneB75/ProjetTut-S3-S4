<?php
	// Informations d'identification
	define('DB_SERVER', 'rayane.space');
	define('DB_USERNAME', 'projet');
	define('DB_PASSWORD', 'yZ5RufZ3LUVbpUPr');
	// pas foufou de le mettre en clair ici mais on verra plus tard si possible de l'intégrer autre part
	define('DB_NAME', 'registration');

	// Connexion à la base de données MySQL 
	$conn = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);

	// Vérifier la connexion
	if($conn === false){
		die("ERREUR : Impossible de se connecter. " . mysqli_connect_error());
	}
?>