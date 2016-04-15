with Ada.Strings.Maps.Constants;
with Ada.Strings.Fixed;
with Ada.Text_IO;

package body Tree is

function New_Tree return Tree  is	
	RetTree : Tree;
begin -- New_Tree
	RetTree := new Node;
	return RetTree;
end New_Tree;

function Tri_Mot(Chaine_Desordonnee : in String) return String  is
	RetChaine_Ordonnee : String := Chaine_Desordonnee;
begin -- Tri_Mot
	String_Sort(RetChaine_Ordonnee);
	return RetChaine_Ordonnee;
end Tri_Mot;

function Cpte_Occurrence(Chaine_Ordonnee : in String ; cNiveau : in String) return Natural is
	Idx: Natural :=  Ada.Strings.Fixed.Index(Source => Chaine_Ordonnee, Pattern => cNiveau);
begin -- Cpte_Occurrence
	if Idx = 0 then
		return 0;
    else
    	return 1 + Cpte_Occurrence(Chaine_Ordonnee(Idx+cNiveau'Length .. Chaine_Ordonnee'Last), cNiveau);
    end if;
end Cpte_Occurrence;

function CharSUCC(Char : in Character) return Character is
	RetChar : Character;
	Index : Integer;
begin -- CharSUCC
	Index := 1 + Character'POS(Char);
	RetChar := Character'VAL(Index);
	return RetChar;
end CharSUCC;

function Amputer_Chaine(Chaine : in String ; NbOccCharARetirer : in Natural) return String is
	RetChaineAmputee 	: Unbounded_String := To_Unbounded_String(Chaine);
	Count				: Natural := 0;
begin -- Amputer_Chaine
	Count := Chaine'Length - NbOccCharARetirer;
	Tail(RetChaineAmputee,Count);
	return To_String(RetChaineAmputee);
end Amputer_Chaine;

function Trouve_Feuille(T : in Tree ; Chaine_En_Cours : in String) return Tree is
	sNiveau			: String 	:= "0";
	Chaine_Suivante : String 	:= "0";
	NumFils			: Natural	:= 0;
begin -- Trouve_Feuille
	-- TODO
	-- Cas à traiter :
	--		- la première lettre n'est pas celle du niveau de l'arbre entrant ou
	--		  il n'y a plus de lettre dans la chaine en cours. On fait un crée un
	--		  un noeud partant du pointeur 0 de la case du niveau correspondant et
	--		  on fait un appel à Trouve_Feuille() sans changer la chaîne en cours
	--
	--		- le première lettre est celle du niveau de l'arbre entrant. On compte
	--		  son nombre d'occurrence pour créer un noeud partant du pointeur correspondant
	--		  si il n'existe pas déjà et on fait un appel à Trouve_Feuille() en "amputant"
	--		  la chaîne en cours du nombre d'occurrence de la lettre rencontrée.
	--			-> créer fonction pour compter le nombre d'occurrence
	--			-> créer fonction pour amputer la chaîne en cours.

	sNiveau(1) := CharSUCC(T.niveau);
	NumFils := Cpte_Occurrence(Chaine_En_Cours,sNiveau);

	if ((T.fils(NumFils) = null) and (sNiveau(1) <= 'z')) then
		T.fils(NumFils) := new Node;
		T.fils(NumFils).niveau := sNiveau(1);
	end if;

	Chaine_Suivante := Amputer_Chaine(Chaine_En_Cours,NumFils);

	return Trouve_Feuille(T.fils(NumFils),Chaine_Suivante);
end Trouve_Feuille;

procedure Insertion(T : in out Tree ; Word : in String) is
	Chaine_Ordonnee : String := Tri_Mot(Word);
	Feuille			: Tree;
begin -- Insertion
	Feuille := Trouve_Feuille(T,Chaine_Ordonnee);
	Prepend(Feuille.anagrammes,To_Unbounded_String(Word)); --à modifier : mettre les bons paramètres pour que ça
								  --pour que ça marche. Mais on insère le mot dans la liste
								  --d'anagrammes
end Insertion;

procedure Search_And_Display(T: in Tree ; Letters : in String) is
	--Modify the Input string to lower case as "b" != "B"
	Input 	: String := Ada.Strings.Fixed.Translate(Letters, Ada.Strings.Maps.Constants.Lower_Case_Map);
	Character_Occurences : Natural := 0;
	Char_to_String : String(1..1); --needed for a char to string conversation for the Cpte_Occurence function
	C : String_Lists.Cursor;
begin -- Search_And_Display

	if (T.niveau < '{') then -- '{' is successive character of 'z', i.e. Node with { is niveau 27

		Char_to_String(1) := T.niveau; --char to string
		Character_Occurences := Cpte_Occurrence(Letters,Char_to_String);

		--iterate over every node node with constraints of the occurence of the character in the Input
		While_Loop :
		while Character_Occurences > 1 loop
			if T.fils(Character_Occurences) /= null then -- /= null valid?
				Search_And_Display(T.fils(Character_Occurences), Letters);
			end if;

			Character_Occurences := Character_Occurences - 1;
		end loop While_Loop;

	-- niveau after 'z' = '{' = 27 - the node of the current this Tree T contains the words in anagrammes
	else 
		C := First(T.anagrammes);
		While Has_Element (C) loop
			Ada.Text_IO.Put_Line( To_Unbounded_String(Element (C)));
			Ada.Text_IO.Put_Line("found word");
			Next(C);
		end loop;
	end if;

end Search_And_Display;

end Tree;
