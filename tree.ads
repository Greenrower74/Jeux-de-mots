with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

with Ada.TEXT_IO, Ada.INTEGER_TEXT_IO;
use Ada.TEXT_IO, Ada.INTEGER_TEXT_IO;

with Ada.Containers.Doubly_Linked_Lists;

with Ada.Containers.Generic_Array_Sort;

with Ada.Strings.Fixed;

with Ada.Characters.Handling;

package Tree is

	type Tree is private;

	package String_Lists is
		new Ada.Containers.Doubly_Linked_Lists(Unbounded_String);
	use String_Lists;

	function New_Tree return Tree;
	procedure Insertion(T : in out Tree ; Word : in String);
	procedure Search_And_Display(T : in Tree ; Letters : in String);

-- Prototypes des fonctions personnelles :

	-- Fonction triant les lettres du mot dans l'ordre alphabétique
	function Tri_Mot(Chaine_Desordonnee : in String) return String;


	-- Fonction comptant le nb d'occurrence de la lettre du niveau correspondant en début de chaine
	-- ordonnee afin de déterminer le pointeur à utiliser dans Trouve_Feuille()
	function Cpte_Occurrence(Chaine_Ordonnee : in String ; cNiveau : in String) return Natural;

	function CharSUCC(Char : in Character) return Character;

	function Amputer_Chaine(Chaine : in String ; NbOccCharARetirer : in Natural) return String;

	procedure String_Sort is
		new Ada.Containers.Generic_Array_Sort(Positive,Character,String);

	-- Fonction récursive cherchant/créant le chemin pour atteindre la feuille
	-- correspondant au mot à placer dans la liste
	function Trouve_Feuille(T : in Tree ; Chaine_En_Cours : in String) return Tree;

private

	type Node;
	type Tree is access Node;
	type Tableau_Pointeur is array(0..10) of Tree;
	type Node is
	record
		fils		: Tableau_Pointeur := (others => NULL);
		niveau		: Character := '`'; -- ` pour la racine 
		anagrammes	: String_Lists.List;
	end record;

end Tree;
