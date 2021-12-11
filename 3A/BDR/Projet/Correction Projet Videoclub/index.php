<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Application Vidéoclub</title>
 
  <meta name="viewport" content="width=device-width, initial-scale
exit;
=1.0" />
  <link rel="stylesheet" href="./css/bootstrap.min.css" type="text/css" />

  <script type="text/javascript" src="./js/jquery-3.2.1.min.js" ></script>
 <script type="text/javascript" src="./js/popper.js"></script>
  <script src="./js/bootstrap.min.js" ></script>

 
</head>
<body class="container">
  <h1> Gestion d'un vidéoclub, Menu</h1>
  <ul class="nav nav-tabs">
  <li class="nav-item "><a class="nav-link active" href="#listeFilms">Liste des films</a></li>
  <li class="nav-item"><a class="nav-link" href="#listeAbonnes">Liste des abonnés</a></li>
  <li class="nav-item"><a class="nav-link" href="#emprunt">Emprunt d'un DVD</a></li>
  </ul>
  
<?php 
  require("./fonctionsVideoclub.php") ;
  $base=connexionBase() ;
  ?>
  <div class="row">
  
  
  <div class="col-6">
  <h1 id="listeFilms" > Liste des films</h1>
<?php
  $films=getFilms($base) ;
?>
  <table class="table table-bordered table-striped">
    <thead class="thead-dark"><tr><th>Titre</th><th>Réalisateur</th><th>Année Production</th></tr></thead>
    <tbody>
<?php
    foreach($films as $film) 
      echo "<tr><td>".$film["titre"]."</td><td>".$film["realisateur"].
           "</td><td>".$film["anneeproduction"]."</td></tr>" ;
?>
    </tbody>
  </table>
  </div>
  <div class="col-6" >
  <h1 id="listeAbonnes" > Liste des abonnés</h1>
<?php
  $abonnes=getAbonnes($base) ;
?>
  <table class="table table-bordered table-striped">
    <thead class="thead-dark"><tr><th>Num</th><th>Prénom</th><th>Nom</th></tr></thead>
    <tbody>
<?php
    foreach($abonnes as $abo) 
      echo "<tr><td>".$abo["nab"]."</td><td>".$abo["prenomab"].
           "</td><td>".$abo["nomab"]."</td></tr>" ;
?>
    </tbody>
  </table>
  </div>
</div>
  <h1 id="emprunt"> Emprunt d'un DVD</h1>
  <form action="emprunt.php" method="POST">
    Nom de l'abonné : <input type="text" name="nomab" required /> 
    Titre du film : <input type="text" name="titre" required />
    <input type="submit" class="btn btn-success" value="Emprunter" />
  </form>
</body>
</html>
