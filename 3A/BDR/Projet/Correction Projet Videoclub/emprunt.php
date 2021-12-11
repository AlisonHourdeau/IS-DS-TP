"<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Application Vidéoclub</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="./css/bootstrap.min.css" />

  <script src="./js/jquery-3.2.1.min.js" ></script>
  <script src="./js/bootstrap.min.js" ></script>
</head>
<body class="container">
  <h1> Emprunt d'un DVD</h1>
<?php
  require("./fonctionsVideoclub.php") ;

  extract($_POST) ;
  echo "Nom de l'abonné :".$nomab."<br />\n" ;
  echo "Titre du film :".$titre."<br /><br /><br /><br />\n" ;
  // connexion à une base
  $base=connexionBase() ;
  
  $nab=checkAbonneExiste($base,$nomab) ;
  if ($nab==-1) { ?>
    <div class="alert alert-danger">Erreur l'abonné n'existe pas dans la base</div>
  <?php
    exit ;
  }

  $nfilm=checkFilmExiste($base,$titre) ;
  if ($nfilm==-1){?>
    <div class="alert alert-danger">Erreur, le film n'existe pas dans la base</div>
  <?php
    exit ;
  }
  $ndvd=checkDvdDisponible($base,$nfilm) ;
  if ($ndvd==-1) {?>
    <div class="alert alert-danger">Erreur, plus de DVD disponible</div>
  <?php
    exit ;
  }
  $nb=checkNbEmpruntsActuels($base,$nab) ;
  if ($nb>=3) {?>
    <div class="alert alert-danger">Erreur, pas plus de trois emprunts</div>
  <?php
    exit ;
  }
  $ok=emprunt($base,$ndvd, $nab) ;
  if ($ok) {?>
    <div class="alert alert-success">Vous venez d'emprunter le DVD : <?= $ndvd; ?></div>
  <?php 
  } else {?> 
     <div class="alert alert-danger">Echec de l'emprunt</div>
  <?php 
  }
  $base=null ; // déconnexion base
?>
</body>
</html>
