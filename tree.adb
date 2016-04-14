
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
begin -- Search_And_Display
	-- TODO
	null;
end Search_And_Display;

end Tree;

--	TODO:

-- Insertion :
-- 	1) Tri_Mot() : 	fonction prenant en entrée le mot à ranger dans l'arbre.
--					Elle trie les lettres dans l'ordre alphabétique pour
--					permettre de le ranger plus facilement.
--
--	2) Trouve_Feuille() :	Fonction récursive. Elle prend en entrée un pointeur
--							sur l'arbre en cour ainsi que le mot en cours. Ensuite
--							à chaque appel elle crée le noeud correspondant à la
--							première lettre du mot reçu, ie elle reçoit aacol. Elle
--							créera le noeud 2A car il y a deux a (d'où l'utilité de
--							Tri_Mot()) ou si il existe déjà elle se dirige dessus.
--							Ensuite à l'appel suivant elle a col. La première lettre
--							est un c or il faut créer la case 0B. Donc on compare la
--							première lettre avec la lettre correspondant au niveau où
--							on se trouve dans l'arbre. Et ainsi de suite.							
--
-- Search_And_Display!
--	1) reprendre ou adapter fonction du 1) précédent pour calculer un chemin
--
--	2) faire fonction pour afficher tous les anagrammes de la liste