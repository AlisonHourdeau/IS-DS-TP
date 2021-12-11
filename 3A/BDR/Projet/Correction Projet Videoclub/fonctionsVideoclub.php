<?php
  /**
   * permet de se connecter à la base videoclub
   * quitte le programme si échec
   * retourne la ressource de la base connectée
  **/
  function connexionBase() {
    $server="localhost";
    $user="demo" ;
    $password="postgres" ;
    $base="videoclub" ;
      
    $base=pg_connect("host=$server dbname=$base user=$user password=$password") 
          or die('Connexion impossible: '.pg_last_error()) ;
    return $base ;
    
  }

  /** liste des films */
  function getFilms($base) {
   $requeteSQL="select titre, realisateur, anneeproduction from film" ; 
   $resultat=pg_query($base,$requeteSQL) 
             or die("Erreur SQL liste films !<br />$requeteSQL<br />") ;

   return pg_fetch_all($resultat) ;
  }
  
  /** liste des abonnés */
  function getAbonnes($base) {
   $requeteSQL="select nab, prenomab, nomab from abonne" ; 
   $resultat=pg_query($base,$requeteSQL) 
             or die("Erreur SQL liste abonnes !<br />$requeteSQL<br />") ;

   return pg_fetch_all($resultat) ;
 } 
  

 /** 
  * renvoie le numéro de l'abonné de nom $nomab s'il existe
  * renvoie -1 sinon
  * quitte le programme si erreur requête
  */

 function checkAbonneExiste($base,$nomab) {
   $requeteSQL="select nab from abonne where nomab='$nomab' limit 1" ; // on ne gère pas les homonymes
   $resultat=pg_query($base,$requeteSQL) 
             or die("Erreur SQL existence abonné !<br />$requeteSQL<br />") ;
   if (pg_num_rows($resultat)==0) return -1 ;
   $ligne=pg_fetch_assoc($resultat) ;
   return $ligne["nab"] ;
 }
 
 /** 
  * renvoie le numéro du film de titre $titre s'il existe
  * renvoie -1 sinon
  * quitte le programme si erreur requête
  */
 function checkFilmExiste($base,$titre) {
   $requeteSQL="select nfilm from film where titre='$titre' limit 1" ;
   $resultat=pg_query($base,$requeteSQL) or die("Erreur SQL !<br />$requeteSQL<br />") ;
   if (pg_num_rows($resultat)==0) return -1 ;
   $ligne=pg_fetch_assoc($resultat) ;
   return $ligne["nfilm"] ;
 }
 
 /** 
  * renvoie le numéro d'un dvd de $nfilm disponible
  * renvoie -1 sinon
  * quitte le programme si erreur requête
  */
 function checkDvdDisponible($base,$nfilm) {
   $requeteSQL="select dvd.ndvd from dvd where nfilm=$nfilm and ".
   "ndvd not in (select ndvd from emprunt where datefin is null) limit 1" ;
   $resultat=pg_query($base,$requeteSQL) or die("Erreur SQL !<br />$requeteSQL<br />") ;
   if (pg_num_rows($resultat)==1) { // au moins un DVD dispo
     $ligne=pg_fetch_assoc($resultat) ;
     return $ligne["ndvd"] ;
   } else return -1 ;
 }
 
 /** 
  * renvoie le nbre d'emprunts actuels de l'abonné $nab
  * quitte le programme si erreur requête
  */
 function checkNbEmpruntsActuels($base,$nab) {
   $requeteSQL="select count(*) as nb from emprunt where nab=$nab and datefin is null" ;
   $resultat=pg_query($base,$requeteSQL) or die("Erreur SQL !<br />$requeteSQL<br />") ;
   $ligne=pg_fetch_assoc($resultat) ;
   return $ligne["nb"] ;
 }
 
 /** 
  * opération d'emprunt du dvd $dvd pour l'abonné $nab
  * renvoie 1 si l'opération est réalisée, 0 sinon
  **/
 function emprunt($base,$ndvd, $nab) {
   $requeteSQL="insert into emprunt(nab,ndvd, datedeb, datefin) values($nab,$ndvd,now(),null)" ;
   $result=pg_query($base,$requeteSQL) ;
   return pg_affected_rows($result) ;
 }
?>
