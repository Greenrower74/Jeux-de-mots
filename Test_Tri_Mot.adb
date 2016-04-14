with Tree;
use Tree;

with Ada.TEXT_IO, Ada.INTEGER_TEXT_IO;
use Ada.TEXT_IO, Ada.INTEGER_TEXT_IO;

procedure Test_Tri_Mot is
	Mot 	: String	:= "hbdilyotphjbjbffwb";
	NbOcc	: Natural	:= 0;
	Char	: Character	:= '`';
	Chaine	: String	:= "0";
begin -- Test_Tri_Mot
	-- Essai de l'inversion des caractères
	Put("Mot normal : ");
	Put_Line(Mot);
	Mot := Tri_Mot(Mot);
	Put("Mot inversé : ");
	Put_Line(Mot);

	-- Essai du comptage du nombre d'occurrence
	NbOcc := Cpte_Occurrence(Mot,"b");
	Put("NbOcc b = ");
	Put(NbOcc);
	New_Line;

	-- Essai de CharSUCC()
	Char := CharSUCC(Char);
	Put("Char = ");
	Put(Char);
	New_Line;

end Test_Tri_Mot;