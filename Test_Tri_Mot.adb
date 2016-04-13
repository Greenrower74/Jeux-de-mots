with Tree;
use Tree;

with Ada.TEXT_IO;
use Ada.TEXT_IO;

procedure Test_Tri_Mot is
	Mot : String := "kate";
begin -- Test_Tri_Mot
	Put("Mot normal : ");
	Put_Line(Mot);
	Mot := Tri_Mot(Mot);
	Put("Mot inversé : ");
	Put_Line(Mot);
end Test_Tri_Mot;