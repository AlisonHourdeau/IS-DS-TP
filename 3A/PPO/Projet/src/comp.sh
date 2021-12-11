clear

echo Compilation :
echo -------------

javac -Xlint:unchecked -Xdiags:verbose ./Monopoly/Cases/*.java
javac -Xlint:unchecked -Xdiags:verbose ./Monopoly/Joueurs/*.java
javac -Xlint:unchecked -Xdiags:verbose ./Monopoly/Plateaux/*.java
javac -Xlint:unchecked -Xdiags:verbose ./Monopoly/Configurations/*.java
javac -Xlint:unchecked -Xdiags:verbose ./Monopoly/Simulation.java
