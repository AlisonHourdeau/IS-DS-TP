--1 Liste des noms et prenoms des etudiants
select nom,prenom from etudiant;

--2 Liste des noms des etudiants de la specialité MIS
select nom from etudiant join specialite on etudiant.refspecialite = specialite.nums where specialite.noms = 'MIS';

--3 Liste des noms et des scores des etudiants de la specialite CTG par ordre alpĥbetique 
select nom,score from passe join etudiant on passe.refetudiant=etudiant.nume join specialite on etudiant.refspecialite = specialite.nums where specialite.noms = 'CTG' order by nom ASC;

--4 Les dates et libellés des tests passés par l'étudiant de numéro 10
select date_test,libelle from passe join test on passe.reftest = test.numt join etudiant on passe.refetudiant = etudiant.nume WHERE nume=10;

--Deuxième façon de faire la question 4
select date_test,libelle from passe join test on passe.reftest = test.numt WHERE refetudiant=10;

--5 min max pour chaque test 
select numt,min(score),max(score) from passe join test on passe.reftest=test.numt group by numt; 

--6 La liste des noms d'étudiants ayant obtenu un score supérieur à 750
select DISTINCT nom from passe join etudiant on passe.refetudiant=etudiant.nume where passe.score >750;

--7 Liste des noms des etudiants ayant passé au moins 3 tests 
select nom,prenom from passe join etudiant on passe.refetudiant=etudiant.nume group by nume having count(*)>=3;

--8 La moyenne des scores par spécialité
select noms as specialite,AVG(score) as moyenne from passe join etudiant on passe.refetudiant=etudiant.nume join specialite on etudiant.refspecialite=specialite.nums group by noms;

--9 les prenoms et noms des étudiants ayant obtenu un TOEIC officiel superieur ou égal à 785
select DISTINCT nom,prenom from passe join etudiant on passe.refetudiant = etudiant.nume join test on passe.reftest=test.numt where passe.score>785 and officiel=true;

--10 La liste des noms des étudiants ayant passé aucun test 
select nom,prenom from etudiant WHERE nume NOT IN (select DISTINCT passe.refetudiant from passe);
