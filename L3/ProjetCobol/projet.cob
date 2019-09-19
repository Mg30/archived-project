IDENTIFICATION DIVISION.
       PROGRAM-ID.proj.
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
       SELECT ftournois ASSIGN TO "tournoi.dat"
       ORGANIZATION indexed
       ACCESS IS DYNAMIC
       RECORD KEY IS fto_id
       ALTERNATE RECORD KEY IS fto_typeP WITH DUPLICATES
       ALTERNATE RECORD KEY IS fto_rgTour WITH DUPLICATES
       FILE STATUS IS ftour_stat.
       SELECT fjoueurs ASSIGN TO "joueur.dat"
       ORGANIZATION indexed
       ACCESS IS DYNAMIC
       RECORD KEY IS fjo_id
       ALTERNATE RECORD KEY IS fjo_ville WITH DUPLICATES
       ALTERNATE RECORD KEY IS fjo_pts WITH DUPLICATES
       FILE STATUS IS fjo_stat.
       SELECT fcle ASSIGN TO "cle.dat"
       ORGANIZATION indexed
       ACCESS IS DYNAMIC
       RECORD KEY IS fcle_numA
       FILE STATUS IS fcle_stat.
       SELECT fparties ASSIGN TO "partie.dat"
       ORGANIZATION indexed
       ACCESS IS DYNAMIC
       RECORD KEY IS fpa_numP
       ALTERNATE RECORD KEY IS fpa_type WITH DUPLICATES
       ALTERNATE RECORD KEY IS fpa_temps WITH DUPLICATES
       FILE STATUS IS fpa_stat.
       SELECT fderoulement ASSIGN TO "deroulement.dat"
       ORGANIZATION indexed
       ACCESS IS DYNAMIC
       RECORD KEY IS fder_idDerou
       ALTERNATE RECORD KEY IS fder_tour WITH DUPLICATES
       ALTERNATE RECORD KEY IS fder_idT WITH DUPLICATES
       ALTERNATE RECORD KEY IS fder_touridT WITH DUPLICATES
       FILE STATUS IS fder_stat.
DATA DIVISION.
FILE SECTION.
       FD ftournois.
       01 ftourTamp.
              02 fto_id PIC 9(3).
              02 fto_sem PIC 9(3).
              02 fto_ville PIC X(30).
              02 fto_nbplaces PIC 9(3).
              02 fto_ntours PIC 9(2).
              02 fto_typeP PIC 9(2).
              02 fto_rgTour PIC 9(1).
       FD fjoueurs.
       01 fjoTamp.
              02 fjo_id PIC 9(3).
              02 fjo_nom PIC X(30).
              02 fjo_prenom PIC X(30).
              02 fjo_age PIC 9(2).
              02 fjo_ville PIC X(30).
              02 fjo_pts PIC 9(4).
       FD fcle.
       01 fcleTamp.
              02 fcle_numA PIC 9(3).
              02 fcle_idJ PIC 9(3).
              02 fcle_idP PIC 9(3).
              02 fcle_idT PIC 9(3).
       FD fparties.
       01 fpaTamp.
              02 fpa_numP PIC 9(2).
              02 fpa_temps PIC 9(2).
              02 fpa_type PIC X(50).
       FD fderoulement.
       01 fderTamp.
              02 fder_idDerou.
                     03 fder_idJ1 PIC 9(3).
                     03 fder_idJ2 PIC 9(3).
                     03 fder_idT PIC 9(2).
              02 fder_tour PIC 9(2).
              02 fder_idV PIC 9(3).
              02 fder_touridT PIC X(5).
WORKING-STORAGE SECTION.
       77 ftour_stat PIC 9(2).
       77 fjo_stat PIC 9(2).
       77 fcle_stat PIC 9(2).
       77 fpa_stat PIC 9(2).
       77 fder_stat PIC 9(2).
       77 Wto_id PIC 9(2).
       77 Wfin PIC 9(2).
       77 Wtrouve PIC 9(2).
       77 Wsem PIC 9(2).
       77 Wtype_partie PIC 9(2).
       77 Wmodulo PIC 9(2).
       77 Wjo_id PIC 9(2).
       77 Wpa_id PIC 9(2).
       77 Wtemps pic 9(2).
       77 Wouv PIC X(50).
       77 Wexist PIC 9(2).
       77 Wid PIC 9(2).
       77 Wid2 PIC 9(2).
       77 WidT PIC 9(2).
       77 Wmax PIC 9(2).
       77 WnbPlaces PIC 9(3).
       77 Wid3 PIC 9(2).
       77 Wcompt PIC 9(2).
       77 Wchoix PIC 9(2).
       77 Wrep PIC 9(2).
       77 Wnew PIC 9(1).
       77 Wrang PIC 9(1).
       77 Wtest PIC 9(1).
       77 Wnb_jou PIC 9(3).
       77 Wstop pic 9(1).
       77 Wchoix2 PIC 9(2).
       77 Wnon_termine PIC 9(1).
       77 Wnbtours PIC 9(1).
       77 Wresult PIC 9(2).
       77 Wborne PIC 9(2).
       77 Wvainqueur PIC 9(1).
       77 WdejaInscrit PIC 9(1).
       77 Wold_tour pic 9(2).
       77 Wtour PIC 9(2).
       77 cle pic X(10).
       77 cle_tour pic X(10).
       77 Wfdz pic 9(1).
       77 WtouridT pic X(5).
       77 wbeug pic 9(1).
       77 WidJ1 pic 999.
       77 WidJ2 pic 999.
       77 WidV pic 999.
       77 Wnom PIC X(30).
       77 Wprenom PIC X(30).
       77 Wage PIC 99.
       77 Wville PIC x(30).
       77 Wpoints PIC 999.
       77 WtypeP PIC X(40).
       77 WtempsP PIC 9999.
       77 WnbP PIC 999.
       77 WrgT PIC 9.
       77 Wsemaine PIC 99.
       77 WidP PIC 999.
       77 Wchoix3 PIC 9.
       77 Wfin2 pic 9(1).
       77 Wfin3 pic 9(1).
       

PROCEDURE DIVISION.
       OPEN I-O ftournois
       IF ftour_stat= 35 THEN
              OPEN OUTPUT ftournois
       END-IF
       CLOSE ftournois
       OPEN I-O fjoueurs
       IF fjo_stat= 35 THEN
              OPEN OUTPUT fjoueurs
       END-IF
       CLOSE fjoueurs
       OPEN I-O fcle
       IF fcle_stat = 35 THEN
              OPEN OUTPUT fcle
              MOVE 1 to fcle_idJ
              MOVE 1 to fcle_idP
              MOVE 1 to fcle_idT
              WRITE fcleTamp END-WRITE
       END-IF
       CLOSE fcle
       OPEN I-O fderoulement
       IF fder_stat = 35 THEN
              OPEN OUTPUT fderoulement
       END-IF
       CLOSE fderoulement
       OPEN I-O fparties
       IF fpa_stat= 35 THEN
              OPEN OUTPUT fparties
       END-IF
       CLOSE fparties
       PERFORM MENU_P
       STOP RUN.
       MENU_P.
PERFORM WITH TEST AFTER UNTIL Wchoix = 7 OR Wchoix<0 OR Wchoix > 7
              DISPLAY '==========================='
              DISPLAY '---MENU PRINCIPAL---'
              DISPLAY '1-Menu ajout'
              DISPLAY '2-Menu affichage'
              DISPLAY '3-Menu suppression'
              DISPLAY '4-Menu modification'
              DISPLAY '5-Menu recherche'
              DISPLAY '6-Gerer tournoi'
              DISPLAY '7-Quitter'
              ACCEPT Wchoix
                     EVALUATE Wchoix
                     WHEN 1 PERFORM MENU_AJOUT
                     WHEN 2 PERFORM MENU_AFFICHAGE
                     WHEN 3 PERFORM MENU_SUPP
                     WHEN 4 PERFORM MENU_MODIF
                     WHEN 5 PERFORM MENU_RECHERCHE
                     WHEN 6 PERFORM GERER_TOUR
                     WHEN 7 STOP RUN
                     END-EVALUATE
END-PERFORM.
       MENU_SUPP.
PERFORM WITH TEST AFTER UNTIL Wchoix2 = 4 OR Wchoix2<0 OR Wchoix2 >4
              DISPLAY '==========================='
              DISPLAY '-----MENU SUPPRESSION-----'
              DISPLAY '1-Supprimer un tournoi'
              DISPLAY '2-Supprimer un type de partie'
              DISPLAY '3-Supprimer un joueur'
              DISPLAY '4-Retour menu principal'
              ACCEPT Wchoix2
                     EVALUATE Wchoix2
                     WHEN 1 PERFORM  SUPP_TOURNOI
                     WHEN 2 PERFORM SUPP_PARTIE
                     WHEN 3 PERFORM SUPP_JOUEUR
                     WHEN 4 GO TO MENU_P
                     END-EVALUATE
END-PERFORM.
       MENU_MODIF.
PERFORM WITH TEST AFTER UNTIL Wchoix2 = 4 OR Wchoix2<0 OR Wchoix2 >4
              DISPLAY '==========================='
              DISPLAY '-----MENU MODIFICATION-----'
              DISPLAY '1-Modifier un tournoi'
              DISPLAY '2-Modifier un type de partie'
              DISPLAY '3-Modifier un joueur'
              DISPLAY '4-Retour menu principal'
              ACCEPT Wchoix2
                     EVALUATE Wchoix2
                     WHEN 1 PERFORM  MODIF_TOURNOI
                     WHEN 2 PERFORM MODIF_PARTIE
                     WHEN 3 PERFORM MODIF_JOUEUR
                     WHEN 4 GO TO MENU_P
                     END-EVALUATE
END-PERFORM.
       MENU_AJOUT.
PERFORM WITH TEST AFTER UNTIL Wchoix2 = 5 OR Wchoix2<0 OR Wchoix2 >5
              DISPLAY '==========================='
              DISPLAY '-----MENU AJOUT-----'
              DISPLAY '1-Ajouter un tournoi'
              DISPLAY '2-Ajouter un type de partie'
              DISPLAY '3-Ajouter un joueur'
              DISPLAY '4-Ajouter un déroulement'
              DISPLAY '5-Retour menu principal'
              ACCEPT Wchoix2
                     EVALUATE Wchoix2
                     WHEN 1 PERFORM  AJOUT_TOURNOI
                     WHEN 2 PERFORM AJOUT_PARTIE
                     WHEN 3 PERFORM AJOUT_JOUEUR
                     WHEN 4 PERFORM AJOUT_DEROU
                     WHEN 5 GO TO MENU_P
                     END-EVALUATE
END-PERFORM.
       MENU_AFFICHAGE.
PERFORM WITH TEST AFTER UNTIL Wchoix2 = 5 OR Wchoix2<0 OR Wchoix2 >5
              DISPLAY '==========================='
              DISPLAY '-----MENU AFFICHAGE-----'
              DISPLAY '1-Afficher tout les tournois'
              DISPLAY '2-Afficher tout les types de partie'
              DISPLAY '3-Afficher tout les joueurs'
              DISPLAY '4-Afficher les tournois en cours'
              DISPLAY '5-Retour menu principal'
              ACCEPT Wchoix2
                     EVALUATE Wchoix2
                     WHEN 1 PERFORM  AFFICH_TOURNOI
                     WHEN 2 PERFORM AFFICH_PARTIE
                     WHEN 3 PERFORM AFFICH_JOUEUR
                     WHEN 4 PERFORM AFFICHE_TOURNOI_ENCOURS
                     WHEN 5 GO TO MENU_P
                     END-EVALUATE
END-PERFORM.

          MENU_RECHERCHE.
PERFORM WITH TEST AFTER UNTIL Wchoix2 = 5 OR Wchoix2<0 OR Wchoix2 >5
              DISPLAY '==========================='
              DISPLAY '------MENU RECHERCHE------'
              DISPLAY '1-Recherche dans le fichier tournoi'
              DISPLAY '2-Recherche dans le fichier joueur'
              DISPLAY '3-Recherche dans le fichier partie'
              DISPLAY '4-Recherche dans le fichier deroulement'
              DISPLAY '5-Retour au menu principal'
              ACCEPT Wchoix2
                    EVALUATE Wchoix2
                    WHEN 1 PERFORM MENU_RECHERCHE_TOURNOI
                    WHEN 2 PERFORM MENU_RECHERCHE_JOUEUR
                    WHEN 3 PERFORM MENU_RECHERCHE_PARTIE
                    WHEN 4 PERFORM MENU_RECHERCHE_DEROUL
                    WHEN 5 GO TO MENU_P
                    END-EVALUATE
END-PERFORM.

      MENU_RECHERCHE_TOURNOI.
PERFORM WITH TEST AFTER UNTIL Wchoix3 = 9 OR Wchoix3<1 OR Wchoix3>9
              DISPLAY '==========================='
              DISPLAY '-- MENU RECHERCHE TOURNOI --'
              DISPLAY '2-Recherche d informations avec l id du tournoi'
              DISPLAY '3-Recherche de tournoi en fonction de son nombre de places'
              DISPLAY '4-Recherche de tournoi selon un rang donné'
              DISPLAY '5-Recherche de tournoi selon une semaine donnée'
              DISPLAY '6-Recherche de tournoi selon un type d ouverture donnée'
              DISPLAY '7-Recherche de tournoi selon une ville donnée'
              DISPLAY '8-Retour au menu des recherches ?'
              DISPLAY '9-Retour au menu principal'
              ACCEPT Wchoix3
                    EVALUATE Wchoix3
                    WHEN 2 PERFORM RECHERCHE_ID
                    WHEN 3 PERFORM RECHERCHE_nbplaces
                    WHEN 4 PERFORM RECHERCHE_RANGTOURNOI
                    WHEN 5 PERFORM RECHERCHE_SEMAINE
                    WHEN 6 PERFORM RECHERCHE_TYPEPARTIE
                    WHEN 7 PERFORM RECHERCHE_VILLE
                    WHEN 8 GO TO MENU_RECHERCHE
                    WHEN 9 GO TO MENU_P
                    END-EVALUATE
END-PERFORM.

       MENU_RECHERCHE_DEROUL.
PERFORM WITH TEST AFTER UNTIL Wchoix3 = 6 OR Wchoix3<0 OR Wchoix3>6
              DISPLAY '==========================='
              DISPLAY '-- MENU RECHERCHE DEROULEMENT --'
              DISPLAY '1-Recherche d informations avec l id du joueur 1'
              DISPLAY '2-Recherche d informations avec l id du joueur 2'
              DISPLAY '3-Recherche d informations avec l id du tournoi'
              DISPLAY '4-Recherche d informations avec l id du vainqueur'
              DISPLAY '5-Retour au menu des recherches ?'
              DISPLAY '6-Retour au menu principal'
              ACCEPT Wchoix3
                    EVALUATE Wchoix3
                    WHEN 1 PERFORM RECHERCHE_deridjoueur1
                    WHEN 2 PERFORM RECHERCHE_deridjoueur2
                    WHEN 3 PERFORM RECHERCHE_deridtournoi
                    WHEN 4 PERFORM RECHERCHE_deridvainqueur
                    WHEN 5 GO TO MENU_RECHERCHE
                    WHEN 6 GO TO MENU_P
                    END-EVALUATE
END-PERFORM.

        MENU_RECHERCHE_PARTIE.
PERFORM WITH TEST AFTER UNTIL Wchoix3 = 5 OR Wchoix3<0 OR Wchoix3>5
              DISPLAY '==========================='
              DISPLAY '-- MENU RECHERCHE PARTIE --'
              DISPLAY '1-Recherche de partie selon son numéro'
              DISPLAY '2-Recherche de partie selon un temps'
              DISPLAY '3-Recherche de partie selon un type d ouverture'
              DISPLAY '4-Retour au menu des recherches ?'
              DISPLAY '5-Retour au menu principal'
              ACCEPT Wchoix3
                    EVALUATE Wchoix3
                    WHEN 1 PERFORM RECHERCHE_numpP
                    WHEN 2 PERFORM RECHERCHE_partietemps
                    WHEN 3 PERFORM RECHERCHE_partietype
                    WHEN 4 GO TO MENU_RECHERCHE
                    WHEN 5 GO TO MENU_P
                    END-EVALUATE
END-PERFORM.

      MENU_RECHERCHE_JOUEUR .
PERFORM WITH TEST AFTER UNTIL Wchoix3 = 8 OR Wchoix3<0 OR Wchoix3>8
              DISPLAY '==========================='
              DISPLAY '-- MENU RECHERCHE JOUEUR --'
              DISPLAY '1-Recherche d informations avec ID du joueur'
              DISPLAY '2-Recherche d informations avec le nom du joueur'
              DISPLAY '3-Recherche d informations avec le prenom du joueur'
              DISPLAY '4-Recherche d informations avec l age du joueur'
              DISPLAY '5-Recherche d informations avec la ville du joueur'
              DISPLAY '6-Recherche d informations avec le nb de point du joueur'
              DISPLAY '7-Retour au menu des recherches ?'
              DISPLAY '8-Retour au menu principal'
              ACCEPT Wchoix3
                    EVALUATE Wchoix3
                    WHEN 1 PERFORM RECHERCHE_JIDJ
                    WHEN 2 PERFORM RECHERCHE_JNOM
                    WHEN 3 PERFORM RECHERCHE_JPRENOM
                    WHEN 4 PERFORM RECHERCHE_JAGE
                    WHEN 5 PERFORM RECHERCHE_JVILLE
                    WHEN 6 PERFORM RECHERCHE_JNBPTS
                    WHEN 7 GO TO MENU_RECHERCHE
                    WHEN 8 GO TO MENU_P
                    END-EVALUATE
END-PERFORM.
*>Procédure qui permet d'ajouter un enregistrement de type tournoi
       AJOUT_TOURNOI.
PERFORM ID_TOUR
*>Controle de la semaine
PERFORM WITH TEST AFTER UNTIL Wtrouve =0 AND Wtest =0
       MOVE 0 TO Wtest
       DISPLAY 'Donnez la semaine du tournoi'
       ACCEPT Wsem
       PERFORM RECHERCHE_SEM
       IF Wtrouve = 1 THEN
              DISPLAY ' Semaine deja prise'
       END-IF
       IF Wsem IS < 0 OR Wsem IS > 53 THEN
              MOVE 1 TO Wtest
              DISPLAY 'La semaine doit etre compris entre 1 et 52'
       END-IF
END-PERFORM
DISPLAY 'Donnez la ville du tournoi'
ACCEPT fto_ville
PERFORM WITH TEST AFTER UNTIL fto_rgTour > 0 OR fto_rgTour < 3
       DISPLAY 'Donnez le rang du tournoi'
       DISPLAY ' 1-Ouvert à tous'
       DISPLAY ' 2-Ouvert aux joueux ayant plus de 500 pts'
       DISPLAY ' 3-Ouvert aux joueux ayant plus de 1000 pts'
       ACCEPT fto_rgTour
       END-PERFORM
      *>COntrole de existence de la partie
PERFORM WITH TEST AFTER UNTIL Wtrouve IS = 1
       DISPLAY 'Donnez id du type de partie pour ce tournoi'
       PERFORM AFFICH_PARTIE
       ACCEPT Wtype_partie
       PERFORM TYPE_PARTIE_EXIST
       IF Wtrouve = 0 THEN
              PERFORM WITH TEST AFTER UNTIL Wrep = 1 OR Wrep = 2
                     DISPLAY 'Voulez vous  ajouter ce type ?'
                     DISPLAY '1-Oui'
                     DISPLAY '2-Non'
                     ACCEPT Wrep
                     IF Wrep = 1 THEN
                            PERFORM AJOUT_PARTIE
                     END-IF
              END-PERFORM
       END-IF
END-PERFORM
IF fto_rgTour = 1 THEN
       MOVE 32 TO fto_nbplaces
       MOVE  5 TO fto_ntours
END-IF
IF fto_rgTour = 2 THEN
       MOVE 16 TO fto_nbplaces
       MOVE 4 TO fto_ntours
END-IF
IF fto_rgTour = 3 THEN
       MOVE 8 TO fto_nbplaces
       MOVE 3 TO fto_ntours
END-IF
MOVE Wto_id TO fto_id
MOVE Wsem TO fto_sem
MOVE Wtype_partie TO fto_typeP
OPEN I-O ftournois
WRITE ftourTamp
INVALID KEY DISPLAY 'INVALID KEY'
END-WRITE
CLOSE ftournois.
      *> Procédure qui gère les clé primaire de tournois
       ID_TOUR.
OPEN I-O fcle
READ fcle NEXT
AT END
       DISPLAY 'Pas de clé'
NOT AT END
       MOVE fcle_idT TO Wto_id
       COMPUTE fcle_idT = fcle_idT + 1
       REWRITE fcleTamp
CLOSE fcle.
      *> Procédure qui permet d'afficher les parties
        AFFICH_PARTIE.
MOVE 0 TO Wfin
OPEN INPUT fparties
PERFORM WITH TEST AFTER UNTIL  Wfin = 1
       READ fparties NEXT
       AT END
              MOVE 1 TO Wfin
       NOT AT END
              DISPLAY '===================='
              DISPLAY '===================='
              DISPLAY fpa_numP ' ' fpa_type
       END-READ
END-PERFORM
CLOSE fparties.
        AFFICH_TOURNOI.
MOVE 0 TO Wfin
OPEN INPUT ftournois
PERFORM WITH TEST AFTER UNTIL  Wfin = 1
       READ ftournois NEXT
       AT END
              MOVE 1 TO Wfin
       NOT AT END
              DISPLAY '===================='
              DISPLAY '===================='
              DISPLAY 'Tournoi id:' fto_id
              DISPLAY 'Semaine:' fto_sem
              DISPLAY 'Ville:' fto_ville
              DISPLAY 'Nb de tour :' fto_ntours
              DISPLAY 'Type de partie :' fto_typeP
              DISPLAY 'Rang du tournoi :' fto_rgTour
       END-READ
END-PERFORM
CLOSE ftournois.
      *> Procédure qui permet de voir si une semaine est deja prise
        RECHERCHE_SEM.
MOVE 0 TO Wfin
MOVE 0 TO Wtrouve
OPEN INPUT ftournois
PERFORM WITH TEST AFTER UNTIL Wtrouve = 1 OR Wfin = 1
       READ ftournois NEXT
       AT END
              MOVE 1 TO Wfin
       NOT AT END
              IF fto_sem =  Wsem  THEN
                     MOVE 1 TO Wtrouve
              END-IF
       END-READ
END-PERFORM
CLOSE ftournois.
      *>
        RECHERCHE_TOUR_PARTIE.
DISPLAY 'Donnez ID du type de partie a chercher'
ACCEPT Wtype_partie
PERFORM AFFICH_PARTIE
MOVE 0 TO Wfin
MOVE 0 TO Wtrouve
OPEN INPUT ftournois
MOVE Wtype_partie TO fto_typeP
START ftournois KEY IS = fto_typeP
       INVALID KEY
              DISPLAY 'ID partie existe pas'
       NOT INVALID KEY
PERFORM WITH TEST AFTER UNTIL Wtrouve = 1 OR Wfin = 1
       READ ftournois NEXT
              AT END
                     MOVE 1 TO Wfin
              NOT AT END
                     IF fto_typeP IS NOT= Wtype_partie THEN
                            MOVE 1 TO Wtrouve
                     ELSE
                            DISPLAY '===================='
                            DISPLAY '===================='
                            DISPLAY 'Tournoi id:' fto_id
                            DISPLAY 'Semaine:' fto_sem
                            DISPLAY 'Ville:' fto_ville
                            DISPLAY 'Nb de tour :' fto_ntours
                            DISPLAY 'Type de partie :' fto_typeP
                            DISPLAY 'Rang du tournoi :' fto_rgTour
                     END-IF
       END-READ
END-PERFORM
END-START
CLOSE ftournois.
      *>Procédure qui permet de vérifier q'une partie existe bien pour ajouter un tournoi
        TYPE_PARTIE_EXIST.
MOVE 0 TO Wtrouve
OPEN INPUT fparties
MOVE Wtype_partie TO fpa_numP
READ fparties
INVALID KEY
       DISPLAY 'Le type de partie n existe pas'
NOT INVALID KEY
       MOVE 1 TO Wtrouve
END-READ
CLOSE fparties.
      *>Procédure qui permet d'ajouter un joueur
        AJOUT_JOUEUR.
PERFORM ID_JOU
DISPLAY 'Donnez le nom du joueur'
ACCEPT fjo_nom
DISPLAY 'Donnez le prénom du joueur'
ACCEPT fjo_prenom
PERFORM WITH TEST AFTER UNTIL fjo_age > 18
       DISPLAY 'Donnez l age du joueur'
       ACCEPT fjo_age
END-PERFORM
DISPLAY 'Donnez la ville du joueur'
ACCEPT fjo_ville
MOVE 0 TO fjo_pts
MOVE Wjo_id TO fjo_id
OPEN I-O fjoueurs
WRITE fjoTamp
INVALID KEY
       DISPLAY 'INVALID KEY'
END-WRITE
CLOSE fjoueurs.
      *>Procédure qui gere l'id de joueur
       ID_JOU.
OPEN I-O fcle
READ fcle NEXT
AT END
       DISPLAY 'Pas de clé'
NOT AT END
       MOVE fcle_idJ TO Wjo_id
       COMPUTE fcle_idJ = fcle_idJ + 1
       REWRITE fcleTamp
CLOSE fcle.
        AFFICH_JOUEUR.
MOVE 0 TO Wfin
OPEN INPUT fjoueurs
PERFORM WITH TEST AFTER UNTIL  Wfin = 1
       READ fjoueurs NEXT
       AT END
              MOVE 1 TO Wfin
       NOT AT END
              DISPLAY '===================='
              DISPLAY '===================='
              DISPLAY 'ID:' fjo_id
              DISPLAY 'Nom:' fjo_nom
              DISPLAY 'Prénom:' fjo_prenom
              DISPLAY 'Age:' fjo_age
              DISPLAY 'Ville:' fjo_ville
              DISPLAY 'Nb de pts:' fjo_pts
       END-READ
END-PERFORM
CLOSE fjoueurs.
      *> Procédure qui ajoute un type de partie
        AJOUT_PARTIE.
PERFORM ID_PAR
PERFORM WITH TEST AFTER UNTIL Wexist IS = 0
       DISPLAY 'Donnez le temps par joueur'
       ACCEPT Wtemps
       DISPLAY 'Donnez le type de l ouverture'
       ACCEPT Wouv
       PERFORM NEW
       IF Wcompt IS = 1 THEN
              PERFORM PAR_EXIST
       END-IF
END-PERFORM
MOVE Wpa_id TO fpa_numP
MOVE Wtemps TO fpa_temps
MOVE Wouv TO fpa_type
OPEN I-O fparties
WRITE fpaTamp
       INVALID KEY
              DISPLAY 'INVALID KEY'
END-WRITE
CLOSE fparties.
      *>Procédure qui gère id d'une partie
       ID_PAR.
OPEN I-O fcle
READ fcle NEXT
AT END
       DISPLAY 'Pas de clé'
NOT AT END
       MOVE fcle_idP TO Wpa_id
       COMPUTE fcle_idP = fcle_idP + 1
       REWRITE fcleTamp
CLOSE fcle.
      *>Procédure qui permet de déterminer si le fichier partie est vide
       NEW.
MOVE 0 TO Wfin
MOVE 0 TO Wcompt
OPEN INPUT fparties
PERFORM WITH TEST AFTER UNTIL Wcompt = 1 OR Wfin = 1
       READ fparties NEXT
              AT END
                     MOVE 1 TO Wfin
              NOT AT END
                     IF fpa_numP IS NOT = 0 THEN
                            MOVE 1 TO Wcompt
                     END-IF
       END-READ
END-PERFORM
CLOSE fparties.
      *> Procédure qui controle que la partie qu on veux ajouter est unique
        PAR_EXIST.
MOVE 0 TO Wexist
MOVE 0 TO Wfin
MOVE 0 TO Wtrouve
MOVE 0 TO Wnew
OPEN INPUT fparties
MOVE Wtemps TO fpa_temps
START fparties KEY IS = fpa_temps
       INVALID KEY
              MOVE 1 TO Wnew
       NOT INVALID KEY
PERFORM WITH TEST AFTER UNTIL Wtrouve = 1 OR Wfin = 1 OR Wexist = 1
       READ fparties NEXT
              AT END
                     MOVE 1 TO Wfin
              NOT AT END
                     IF fpa_temps IS NOT= Wtemps THEN
                            MOVE 1 TO Wtrouve
                     ELSE
                            IF fpa_type = Wouv
                                   MOVE 1 TO Wexist
                            END-IF
                     END-IF
       END-READ
END-PERFORM
END-START
CLOSE fparties.
     *> Procédure qui permet d'ajouter tout les enregistrements correspondants au 1er tour du tournoi dont id est donné
       AJOUT_DEROU.
PERFORM WITH TEST AFTER UNTIL Wtrouve = 0
       DISPLAY 'Donnez id du tournoi'
       ACCEPT WidT
       PERFORM TOURNOI_EXIST
       PERFORM COMPTE_JOUEUR
       IF Wnb_jou IS < fto_nbplaces THEN
              DISPLAY 'Nombre de joueurs insuffisant'
              GO TO MENU_P
       END-IF
END-PERFORM
PERFORM RECHERCHE_MAX
IF Wmax = 0 THEN
       MOVE 1 TO Wtour
       MOVE 0 TO Wcompt
       DIVIDE WnbPlaces BY 2 GIVING WnbPlaces
       END-DIVIDE
       PERFORM WITH TEST AFTER UNTIL Wcompt = WnbPlaces
              COMPUTE Wcompt = Wcompt + 1
              DISPLAY 'Donnez le Resultat de la rencontre N°' Wcompt
              PERFORM VERIF_AJOUT
       END-PERFORM
ELSE
       DISPLAY 'Ajout impossible tournoi Encours/terminé'
END-IF.
      *>Procédure qui vérifie qui ajoute un enregistrement de type deroulement
       VERIF_AJOUT.
       PERFORM WITH TEST AFTER UNTIL Wtrouve = 0 AND WdejaInscrit = 0
              DISPLAY 'Donnez ID du joueur 1'
              ACCEPT Wid
              MOVE Wid to Wid2
              PERFORM JOUEUR_EXIST
              PERFORM JOUEUR_DEJA_ENREG
       END-PERFORM
PERFORM WITH TEST AFTER UNTIL Wtrouve = 0 AND WdejaInscrit = 0
              DISPLAY 'Donnez ID du joueur 2'
              ACCEPT Wid
              PERFORM JOUEUR_EXIST
              PERFORM JOUEUR_DEJA_ENREG
              IF Wid = Wid2 THEN
                     MOVE 1 TO Wtrouve
              END-IF
       END-PERFORM
       PERFORM WITH TEST AFTER UNTIL Wid3 = Wid OR Wid3 = Wid2
              DISPLAY 'Donnez ID du joueur vainqueur'
              ACCEPT Wid3
              PERFORM ADD_PTS_JOUEUR
       END-PERFORM
       MOVE Wid2 to fder_idJ1
       MOVE Wid to fder_idJ2
       MOVE Wid3 to fder_idV
       MOVE WidT TO fder_idT
       MOVE WtouridT TO fder_touridT
       MOVE 01 TO fder_tour
       CLOSE  fderoulement
       OPEN I-O fderoulement
       WRITE fderTamp
              INVALID KEY
              DISPLAY 'cle invalide'
              NOT INVALID KEY move 0 to Wbeug
       END-WRITE
       CLOSE fderoulement.
     *> Procédure qui verifie q un existe et qu il a le nb de point suffisant pour etre inscrit dans le tournoi
       JOUEUR_EXIST.
MOVE 0 TO Wtrouve
OPEN INPUT fjoueurs
MOVE Wid TO fjo_id
READ fjoueurs
       INVALID KEY
              MOVE 1 TO Wtrouve
              DISPLAY 'Le joueur n existe pas'
       NOT INVALID KEY
              IF Wrang = 2 THEN
                     IF fjo_pts IS < 500 THEN
                            MOVE 1 TO Wtrouve
                        DISPLAY 'Le joueur n as pas le NB de pts requis'
                     END-IF
              END-IF
              IF Wrang = 3 THEN
                     IF fjo_pts IS < 1000 THEN
                            MOVE 1 TO Wtrouve
                      DISPLAY 'Le joueur n as pas le NB de pts requis'
           END-IF
       END-IF
END-READ
CLOSE fjoueurs.
     *> Procédure qui verifie qu un tournoi existe
       TOURNOI_EXIST.
Move 0 to Wrang
MOVE 0 TO Wtrouve
OPEN INPUT ftournois
MOVE WidT TO fto_id
READ ftournois
       INVALID KEY
       MOVE 1 TO Wtrouve
NOT INVALID KEY
       MOVE fto_nbplaces TO WnbPlaces
       MOVE fto_rgTour TO Wrang
       MOVE fto_ntours to Wtours
END-READ
CLOSE ftournois.
     *> Procédure qui recupere le tour en cours du tournoi
       RECHERCHE_MAX.
OPEN INPUT fderoulement
MOVE 0 TO Wfin
MOVE 0 TO Wmax
MOVE WidT TO fder_idT
START fderoulement KEY IS = fder_idT
INVALID KEY DISPLAY 'AUCUN TOURNOI'
NOT INVALID KEY
PERFORM WITH TEST AFTER UNTIL Wfin = 1
       READ fderoulement NEXT
              AT END
                     MOVE 1 TO Wfin
              NOT AT END
IF fder_idT = WidT THEN
              IF fder_tour > Wmax THEN
                     MOVE fder_tour to Wmax
              END-IF
ELSE
       MOVE 1 to Wfin
END-IF
       END-READ
END-PERFORM
CLOSE fderoulement.
        COMPTE_JOUEUR.
MOVE 0 TO Wfin
MOVE 0 TO Wnb_jou
OPEN INPUT fjoueurs
PERFORM WITH TEST AFTER UNTIL  Wfin = 1
       READ fjoueurs NEXT
       AT END
              MOVE 1 TO Wfin
       NOT AT END
              COMPUTE Wnb_jou = Wnb_jou + 1
       END-READ
END-PERFORM
CLOSE fjoueurs.
       SUPP_TOURNOI.
PERFORM WITH TEST AFTER UNTIL Wtrouve = 0
       DISPLAY 'Donnez id du tournoi à supprimer'
       PERFORM AFFICH_TOURNOI
       ACCEPT WidT
       PERFORM TOURNOI_EXIST
END-PERFORM
PERFORM RECHERCHE_MAX
IF Wmax = 0 THEN
       OPEN I-O ftournois
       MOVE WidT TO fto_id
       READ ftournois
              INVALID KEY
                     DISPLAY 'Error'
              NOT INVALID KEY
                     DELETE ftournois RECORD
       END-READ
CLOSE ftournois
DISPLAY 'Supression effectuee'
ELSE
       DISPLAY 'Suppression impossible tournoi Encours/terminé'
END-IF.
       SUPP_PARTIE.
PERFORM WITH TEST AFTER UNTIL Wtrouve IS = 1
       DISPLAY 'Donnez ID du type de partie a supprimer'
       PERFORM AFFICH_PARTIE
       ACCEPT Wtype_partie
       PERFORM TYPE_PARTIE_EXIST
END-PERFORM
MOVE 0 TO Wfin
MOVE 0 TO Wtrouve
MOVE 0 TO Wstop
OPEN INPUT ftournois
MOVE Wtype_partie TO fto_typeP
START ftournois KEY IS = fto_typeP
       INVALID KEY
              MOVE 0 TO Wstop
       NOT INVALID KEY
PERFORM WITH TEST AFTER UNTIL Wtrouve = 1 OR Wfin = 1
       READ ftournois NEXT
              AT END
                     MOVE 1 TO Wfin
              NOT AT END
                     IF fto_typeP IS NOT= Wtype_partie THEN
                            MOVE 1 TO Wtrouve
                     ELSE
                            MOVE 1 TO Wstop
                     END-IF
       END-READ
END-PERFORM
END-START
CLOSE ftournois
IF Wstop = 1 THEN
       DISPLAY 'Suppression impossible type de partie utilisee'
ELSE
       OPEN I-O fparties
       MOVE Wtype_partie TO fpa_numP
       READ fparties
              INVALID KEY
                     DISPLAY 'Error'
              NOT INVALID KEY
                     DELETE fparties RECORD
       END-READ
CLOSE fparties
DISPLAY 'Supression effectuee'
END-IF.
      *> a modifer en tenant compte indexé
       SUPP_JOUEUR.
PERFORM WITH TEST AFTER UNTIL Wtrouve = 0
              PERFORM AFFICH_JOUEUR
              DISPLAY 'Donnez ID Joueur a supprimer'
              ACCEPT Wid
              PERFORM JOUEUR_EXIST
END-PERFORM
OPEN I-O fderoulement
MOVE 0 To Wfin
MOVE 0 To Wtrouve
MOVE WidT to fder_idT
START fderoulement, KEY IS = fder_idT
INVALID KEY DISPLAY 'AUCUN TOURNOI'
NOT INVALID KEY
PERFORM WITH TEST AFTER UNTIL Wfin = 1 or Wtrouve = 1
       READ fderoulement NEXT
              AT END
                     MOVE 1 TO Wfin
              NOT AT END
IF fder_idT = WidT THEN
              IF Wid = fder_idJ1 or Wid = fder_idJ2  THEN
                     MOVE 1 to Wtrouve
              END-IF
ELSE
       MOVE 1 to Wfin
END-IF
       END-READ
END-PERFORM
close fderoulement
IF Wtrouve = 1 THEN
       DISPLAY 'Suppression impossible joueur engage ds un tournoi'
ELSE
       OPEN I-O fjoueurs
              MOVE Wid TO fjo_id
              READ fjoueurs
                     INVALID KEY
                            DISPLAY 'Error'
                     NOT INVALID KEY
                            DELETE fjoueurs RECORD
              END-READ
       CLOSE fjoueurs
       DISPLAY 'Supression effectuee'
END-IF.
      *> a modifier en indexe
       MODIF_JOUEUR.
PERFORM WITH TEST AFTER UNTIL Wtrouve = 0
              PERFORM AFFICH_JOUEUR
              DISPLAY 'Donnez ID Joueur a modifier'
              ACCEPT Wid
              PERFORM JOUEUR_EXIST
END-PERFORM
OPEN I-O fderoulement
MOVE 0 To Wfin
MOVE 0 To Wtrouve
START fderoulement, KEY IS = fder_idT
INVALID KEY DISPLAY 'AUCUN TOURNOI'
NOT INVALID KEY
PERFORM WITH TEST AFTER UNTIL Wfin = 1 or Wtrouve = 1
       READ fderoulement NEXT
              AT END
                     MOVE 1 TO Wfin
              NOT AT END
IF fder_idT = WidT THEN
              IF Wid = fder_idJ1 or Wid = fder_idJ2  THEN
                     MOVE 1 to Wtrouve
              END-IF
ELSE
       MOVE 1 to Wfin
END-IF
       END-READ
END-PERFORM
close fderoulement
IF Wtrouve = 1 THEN
       DISPLAY 'Modification impossible joueur engage ds un tournoi'
ELSE
       OPEN I-O fjoueurs
              MOVE Wid TO fjo_id
              READ fjoueurs
                     INVALID KEY
                            DISPLAY 'Error'
                     NOT INVALID KEY
                            DISPLAY 'Donnez le nom du joueur'
                            ACCEPT fjo_nom
                            DISPLAY 'Donnez le prénom du joueur'
                            ACCEPT fjo_prenom
                    PERFORM WITH TEST AFTER UNTIL fjo_age > OR EQUAL 18
                            DISPLAY 'Donnez l age du joueur'
                            ACCEPT fjo_age
                    END-PERFORM
                    DISPLAY 'Donnez la ville du joueur'
                    ACCEPT fjo_ville
                    REWRITE fjoTamp
              END-READ
       CLOSE fjoueurs
       DISPLAY 'Modification effectuee'
END-IF.


       MODIF_PARTIE.
PERFORM WITH TEST AFTER UNTIL Wtrouve IS = 1
       DISPLAY 'Donnez ID du type de partie a modifier'
       PERFORM AFFICH_PARTIE
       ACCEPT Wtype_partie
       PERFORM TYPE_PARTIE_EXIST
END-PERFORM
MOVE 0 TO Wfin
MOVE 0 TO Wtrouve
MOVE 0 TO Wstop
OPEN INPUT ftournois
MOVE Wtype_partie TO fto_typeP
START ftournois KEY IS = fto_typeP
       INVALID KEY
              MOVE 0 TO Wstop
       NOT INVALID KEY
PERFORM WITH TEST AFTER UNTIL Wtrouve = 1 OR Wfin = 1
       READ ftournois NEXT
              AT END
                     MOVE 1 TO Wfin
              NOT AT END
                     IF fto_typeP IS NOT= Wtype_partie THEN
                            MOVE 1 TO Wtrouve
                     ELSE
                            MOVE 1 TO Wstop
                     END-IF
       END-READ
END-PERFORM
END-START
CLOSE ftournois
IF Wstop = 1 THEN
       DISPLAY 'Modification impossible type de partie utilisee'
ELSE
       PERFORM WITH TEST AFTER UNTIL Wexist IS = 0
              DISPLAY 'Donnez le temps par joueur'
              ACCEPT Wtemps
              DISPLAY 'Donnez le type de l ouverture'
              ACCEPT Wouv
              PERFORM NEW
              IF Wcompt IS = 1 THEN
                     PERFORM PAR_EXIST
              END-IF
       END-PERFORM
       OPEN I-O fparties
       MOVE Wtype_partie TO fpa_numP
       READ fparties
              INVALID KEY
                     DISPLAY 'Error'
              NOT INVALID KEY
                     MOVE Wtemps TO fpa_temps
                     MOVE Wouv TO fpa_type
                     REWRITE fpaTamp
       END-READ
CLOSE fparties
DISPLAY 'Modication effectuee'
END-IF.


       MODIF_TOURNOI.
PERFORM WITH TEST AFTER UNTIL Wtrouve = 0
       DISPLAY 'Donnez id du tournoi à modifier'
       PERFORM AFFICH_TOURNOI
       ACCEPT WidT
       PERFORM TOURNOI_EXIST
END-PERFORM
PERFORM RECHERCHE_MAX
IF Wmax = 0 THEN
              PERFORM WITH TEST AFTER UNTIL Wtrouve =0 AND Wtest =0
              MOVE 0 TO Wtest
              DISPLAY 'Donnez la semaine du tournoi'
              ACCEPT Wsem
              PERFORM RECHERCHE_SEM
              IF Wtrouve = 1 THEN
                     DISPLAY ' Semaine deja prise'
              END-IF
              IF Wsem IS < 0 OR Wsem IS > 53 THEN
                     MOVE 1 TO Wtest
                     DISPLAY 'La semaine doit etre compris entre 1 et 52'
              END-IF
       END-PERFORM
       OPEN I-O ftournois
       READ ftournois
              INVALID KEY
                     DISPLAY 'Error'
              NOT INVALID KEY
                     DISPLAY 'Donnez la ville du tournoi'
                     ACCEPT fto_ville
          PERFORM WITH TEST AFTER UNTIL fto_rgTour > 0 OR fto_rgTour < 3
              DISPLAY 'Donnez le rang du tournoi'
              DISPLAY ' 1-Ouvert à tous'
              DISPLAY ' 2-Ouvert aux joueux ayant plus de 500 pts'
              DISPLAY ' 3-Ouvert aux joueux ayant plus de 1000 pts'
              ACCEPT fto_rgTour
       END-PERFORM
      *>COntrole de existence de la partie
       PERFORM WITH TEST AFTER UNTIL Wtrouve = 1
              DISPLAY 'Donnez id du type de partie pour ce tournoi'
              PERFORM AFFICH_PARTIE
              ACCEPT Wtype_partie
              PERFORM TYPE_PARTIE_EXIST
              IF Wtrouve = 0 THEN
                     PERFORM WITH TEST AFTER UNTIL Wrep = 1 OR Wrep = 2
                            DISPLAY 'Voulez vous  ajouter ce type ?'
                            DISPLAY '1-Oui'
                            DISPLAY '2-Non'
                            ACCEPT Wrep
                            IF Wrep = 1 THEN
                                   PERFORM AJOUT_PARTIE
                            END-IF
                     END-PERFORM
              END-IF
       END-PERFORM
       IF fto_rgTour = 1 THEN
              MOVE 32 TO fto_nbplaces
              MOVE  5 TO fto_ntours
       END-IF
       IF fto_rgTour = 2 THEN
              MOVE 16 TO fto_nbplaces
              MOVE 4 TO fto_ntours
       END-IF
       IF fto_rgTour = 3 THEN
              MOVE 8 TO fto_nbplaces
              MOVE 3 TO fto_ntours
       END-IF
       MOVE Wsem TO fto_sem
       MOVE Wtype_partie TO fto_typeP
       REWRITE ftourTamp
       END-READ
       CLOSE ftournois
       DISPLAY 'Modification effectuee'
ELSE
       DISPLAY 'Modification impossible tournoi Encours/terminé'
END-IF.

       AFFICHE_TOURNOI_ENCOURS.
MOVE 0 TO Wfin
OPEN INPUT ftournois
PERFORM WITH TEST AFTER UNTIL  Wfin = 1
       READ ftournois NEXT
       AT END
              MOVE 1 TO Wfin
       NOT AT END
              MOVE fto_id to WidT
              PERFORM RECHERCHE_MAX
              IF Wmax < fto_ntours AND Wmax IS NOT = 0 THEN
                     DISPLAY '===================='
                     DISPLAY '======TOURNOI EN COURS======='
                     DISPLAY 'Tournoi id:' fto_id
                     DISPLAY 'Semaine:' fto_sem
                     DISPLAY 'Ville:' fto_ville
                     DISPLAY 'Nb de tour :' fto_ntours
                     DISPLAY 'Type de partie :' fto_typeP
                     DISPLAY 'Rang du tournoi :' fto_rgTour
                     PERFORM RECHERCHE_MAX
                     DISPLAY 'Tour actuel:' Wmax
              END-IF
       END-READ
END-PERFORM
CLOSE ftournois.

       TOURNOI_ENCOURS_EXIST.
Move 0 to Wrang
MOVE 0 TO Wtrouve
MOVE 0 TO Wnbtours
OPEN INPUT ftournois
MOVE WidT TO fto_id
READ ftournois
       INVALID KEY
              MOVE 1 TO Wtrouve
       NOT INVALID KEY
              MOVE fto_rgTour TO Wrang
              MOVE fto_ntours TO Wnbtours
              MOVE fto_nbplaces TO WnbPlaces
END-READ
MOVE fto_id to WidT
PERFORM RECHERCHE_MAX
IF Wmax = 0 OR Wmax = Wnbtours THEN
       MOVE 1 TO Wtrouve
       DISPLAY 'Tournoi pas au 1er tour ou terminé'
END-IF
CLOSE ftournois.

       GERER_TOUR.
PERFORM WITH TEST AFTER UNTIL Wtrouve = 0
       PERFORM AFFICHE_TOURNOI_ENCOURS
       DISPLAY 'Donnez id du tournoi à gérer'
       ACCEPT WidT
       PERFORM TOURNOI_ENCOURS_EXIST
END-PERFORM
MOVE 0 TO Wcompt
MOVE Wmax TO Wold_tour
MOVE Wmax TO Wtour
COMPUTE Wtour = Wtour + 1
       EVALUATE Wtour
              WHEN 2 DIVIDE WnbPlaces BY 4 GIVING Wborne
              WHEN 3 DIVIDE WnbPlaces BY 8 GIVING Wborne
              WHEN 4 DIVIDE WnbPlaces BY 16 GIVING Wborne
              WHEN 5 DIVIDE WnbPlaces BY 32 GIVING Wborne
       END-EVALUATE
DISPLAY 'lA BORNE EST DE ' Wborne
PERFORM WITH TEST AFTER UNTIL Wcompt = Wborne
       COMPUTE Wcompt = Wcompt + 1
       DISPLAY 'Donnez le Resultat de la rencontre N°' Wcompt
       PERFORM AJOUT_DEROU_TOURNOI_ENCOURS
END-PERFORM.



       AJOUT_DEROU_TOURNOI_ENCOURS.
PERFORM WITH TEST AFTER UNTIL Wtrouve = 0 AND Wvainqueur = 1 AND WdejaInscrit = 0
              DISPLAY 'Donnez ID du joueur 1'
              ACCEPT Wid
              MOVE Wid to Wid2
              PERFORM JOUEUR_EXIST
              PERFORM JOUEUR_EST_VAINQUEUR
              PERFORM JOUEUR_DEJA_ENREG
       END-PERFORM
       PERFORM WITH TEST AFTER UNTIL Wtrouve = 0 AND Wid IS NOT = Wid2 AND WdejaInscrit = 0 AND Wvainqueur = 1
              DISPLAY 'Donnez ID du joueur 2'
              ACCEPT Wid
              PERFORM JOUEUR_EXIST
              PERFORM JOUEUR_EST_VAINQUEUR
              PERFORM JOUEUR_DEJA_ENREG
       END-PERFORM
       PERFORM WITH TEST AFTER UNTIL Wid3 = Wid OR Wid3 = Wid2
              DISPLAY 'Donnez ID du joueur vainqueur'
              ACCEPT Wid3
              PERFORM ADD_PTS_JOUEUR
       END-PERFORM
       MOVE Wid2 to fder_idJ1
       MOVE Wid to fder_idJ2
       MOVE Wid3 to fder_idV
       MOVE WidT TO fder_idT
       MOVE Wtour TO fder_tour
       CLOSE  fderoulement
       OPEN I-O fderoulement
       WRITE fderTamp
              INVALID KEY MOVE 0 TO Wbeug
              NOT INVALID KEY MOVE 1 TO Wbeug
       END-WRITE
       DISPLAY fder_stat
       CLOSE fderoulement.
      *> a modifier
       JOUEUR_EST_VAINQUEUR.
OPEN INPUT fderoulement
MOVE 0 TO Wfin
MOVE 0 TO Wvainqueur
MOVE 0 TO Wfdz
STRING WidT'-'Wold_tour INTO fder_touridT
MOVE fder_touridT TO WtouridT
START fderoulement KEY IS = fder_touridT
INVALID KEY MOVE 1 TO Wbeug
NOT INVALID KEY
PERFORM WITH TEST AFTER UNTIL Wfin = 1 OR Wvainqueur = 1 or Wfdz =1
       READ fderoulement NEXT
              AT END
                     MOVE 1 TO Wfin
              NOT AT END
       IF fder_touridT IS = WtouridT THEN
              display 'id JOUEUR VANQ' fder_idV
              IF Wid = fder_idV  THEN
                     MOVE 1 TO Wvainqueur
              END-IF
       ELSE
              MOVE 1 TO Wfdz
       END-IF
       END-READ
END-PERFORM
END-START
IF Wvainqueur = 0 AND Wfdz = 0 THEN
       DISPLAY 'Joueur non qualifié pour ce tour'
end-if
CLOSE fderoulement.
     *> a modifier
        JOUEUR_DEJA_ENREG.
OPEN INPUT fderoulement
MOVE 0 TO Wfin
MOVE 0 TO WdejaInscrit
MOVE 0 TO Wfdz
STRING WidT'-'Wtour INTO fder_touridT
MOVE fder_touridT TO WtouridT
START fderoulement KEY IS = fder_touridT
INVALID KEY MOVE 1 TO Wbeug
NOT INVALID KEY
PERFORM WITH TEST AFTER UNTIL Wfin = 1 OR WdejaInscrit = 1 or Wfdz =1
       READ fderoulement NEXT
              AT END
                     MOVE 1 TO Wfin
       NOT AT END
       IF fder_touridT IS = WtouridT THEN
              IF Wid = fder_idj1 OR Wid = fder_idj2 THEN
                     MOVE 1 TO WdejaInscrit
              END-IF
       ELSE
              MOVE 1 TO Wfdz
       END-IF
       END-READ
END-PERFORM
END-START
IF WdejaInscrit = 1 THEN
       DISPLAY 'Joueur deja renseigné pour ce tour'
end-if
CLOSE fderoulement.

       ADD_PTS_JOUEUR.
MOVE 0 TO Wtrouve
OPEN I-O fjoueurs
MOVE Wid3 TO fjo_id
READ fjoueurs
       INVALID KEY
              MOVE 1 TO Wtrouve
              DISPLAY 'Le joueur n existe pas'
       NOT INVALID KEY
              EVALUATE Wrang
                     WHEN 1 COMPUTE fjo_pts = fjo_pts + 25
                     WHEN 2 COMPUTE fjo_pts = fjo_pts + 50
                     WHEN 3 COMPUTE fjo_pts = fjo_pts + 100
              END-EVALUATE
              REWRITE fjoTamp
END-READ
CLOSE fjoueurs.

RECHERCHE_deridjoueur1.
           OPEN Input fderoulement
           DISPLAY 'Quel id pour le joueur 1  ?'
           ACCEPT WidJ1
           MOVE 0 TO Wfin
           PERFORM WITH TEST AFTER UNTIL Wfin = 1
               READ fderoulement NEXT
               AT END MOVE 1 TO Wfin
               NOT AT END
                   IF WidJ1 = fder_idJ1

                       DISPLAY 'ID du joueur 1  :', fder_idJ1
                       DISPLAY 'ID du joueur 2  :', fder_idJ2
                       DISPLAY 'ID du tournoi   :', fder_idT
                       DISPLAY 'Tour lors du tournoi :', fder_tour
                       DISPLAY 'ID du vainqueur :',fder_idV

                   END-IF
              END-READ
           END-PERFORM
           CLOSE fderoulement.

           RECHERCHE_deridjoueur2.
           OPEN Input fderoulement
           DISPLAY 'Quel id pour le joueur 2 ?'
           ACCEPT WidJ2
           MOVE 0 TO Wfin
           PERFORM WITH TEST AFTER UNTIL Wfin = 1
               READ fderoulement NEXT
               AT END MOVE 1 TO Wfin
               NOT AT END
                   IF WidJ2 = fder_idJ2

                       DISPLAY 'ID du joueur 1  :', fder_idJ1
                       DISPLAY 'ID du joueur 2  :', fder_idJ2
                       DISPLAY 'ID du tournoi   :', fder_idT
                       DISPLAY 'Tour lors du tournoi :', fder_tour
                       DISPLAY 'ID du vainqueur :',fder_idV

                   END-IF
             END-READ
           END-PERFORM
           CLOSE fderoulement.

RECHERCHE_deridtournoi.
           OPEN Input fderoulement
           DISPLAY 'Quel id pour le tournoi ?'
           ACCEPT WidT
           MOVE 0 TO Wfin
           PERFORM WITH TEST AFTER UNTIL Wfin = 1
               READ fderoulement NEXT
               AT END MOVE 1 TO Wfin
               NOT AT END
                   IF WidT = fder_idT

                       DISPLAY 'ID du joueur 1  :', fder_idJ1
                       DISPLAY 'ID du joueur 2  :', fder_idJ2
                       DISPLAY 'ID du tournoi   :', fder_idT
                       DISPLAY 'Tour lors du tournoi :', fder_tour
                       DISPLAY 'ID du vainqueur :',fder_idV

                   END-IF
              END-READ
           END-PERFORM
           CLOSE fderoulement.

RECHERCHE_deridvainqueur.
           OPEN Input fderoulement
           DISPLAY 'Quel id de vainqueur ?'
           ACCEPT WidV
           MOVE 0 TO Wfin
           PERFORM WITH TEST AFTER UNTIL Wfin = 1
               READ fderoulement NEXT
               AT END MOVE 1 TO Wfin
               NOT AT END
                   IF WidV = fder_idV

                       DISPLAY 'ID du joueur 1  :', fder_idJ1
                       DISPLAY 'ID du joueur 2  :', fder_idJ2
                       DISPLAY 'ID du tournoi   :', fder_idT
                       DISPLAY 'Tour lors du tournoi :', fder_tour

                   END-IF
              END-READ
           END-PERFORM
           CLOSE fderoulement.


RECHERCHE_JIDJ.

           OPEN Input fjoueurs
           DISPLAY 'Quel est l id du joueur ?'
           ACCEPT fjo_id
           READ fjoueurs NEXT
           INVALID KEY DISPLAY 'Ce joueur nexiste pas'
           NOT INVALID KEY
               DISPLAY 'ID du joueur :', fjo_id
               DISPLAY 'Nom du joueur :', fjo_nom
               DISPLAY 'Prenom du joueur :', fjo_prenom
               DISPLAY 'Age du joueur :', fjo_age
               DISPLAY 'Ville du joueur :', fjo_ville
               DISPLAY 'Nb points du joueur :', fjo_pts
            END-READ
	   	CLOSE fjoueurs.



RECHERCHE_JNOM.

           OPEN Input fjoueurs
           DISPLAY 'Quel est le nom du joueur ?'
           ACCEPT Wnom
           MOVE 0 TO Wtrouve
           MOVE 0 TO Wfin
           PERFORM WITH TEST AFTER UNTIL Wfin = 1 OR Wtrouve = 0
               READ fjoueurs NEXT
               AT END MOVE 1 TO Wfin
                   DISPLAY 'Aucun joueur pour ce nom'
               NOT AT END
                   IF Wnom = fjo_nom
                      MOVE 1 TO Wtrouve
                      DISPLAY 'ID du joueur :', fjo_id
             		  DISPLAY 'Nom du joueur :', fjo_nom
             		  DISPLAY 'Prenom du joueur :', fjo_prenom
             		  DISPLAY 'Age du joueur :', fjo_age
             		  DISPLAY 'Ville du joueur :', fjo_ville
             		  DISPLAY 'Nb points du joueur :', fjo_pts
                   END-IF
              END-READ
           END-PERFORM
           CLOSE fjoueurs.




RECHERCHE_JPRENOM.

           OPEN Input fjoueurs
           DISPLAY 'Quel est le prenom du joueur ?'
           ACCEPT Wprenom
           MOVE 0 TO Wtrouve
           MOVE 0 TO Wfin
           PERFORM WITH TEST AFTER UNTIL Wfin = 1 OR Wtrouve = 0
               READ fjoueurs NEXT
               AT END MOVE 1 TO Wfin
                   DISPLAY 'Aucun joueur pour ce nom'
               NOT AT END
                   IF Wprenom = fjo_prenom
                      MOVE 1 TO Wtrouve
                      DISPLAY 'ID du joueur :', fjo_id
             		  DISPLAY 'Nom du joueur :', fjo_nom
             		  DISPLAY 'Prenom du joueur :', fjo_prenom
             		  DISPLAY 'Age du joueur :', fjo_age
             		  DISPLAY 'Ville du joueur :', fjo_ville
             		  DISPLAY 'Nb points du joueur :', fjo_pts
                   END-IF
              END-READ
           END-PERFORM
           CLOSE fjoueurs.


RECHERCHE_JAGE.

		   OPEN Input fjoueurs
           DISPLAY 'Quel est l age du joueur ?'
           ACCEPT Wage
           MOVE 0 TO Wtrouve
           MOVE 0 TO Wfin
           PERFORM WITH TEST AFTER UNTIL Wfin = 1 OR Wtrouve = 0
               READ fjoueurs NEXT
               AT END MOVE 1 TO Wfin
                   DISPLAY 'Aucun joueur pour ce nom'
               NOT AT END
                   IF Wage = fjo_age
                      MOVE 1 TO Wtrouve
                      DISPLAY 'ID du joueur :', fjo_id
             		  DISPLAY 'Nom du joueur :', fjo_nom
             		  DISPLAY 'Prenom du joueur :', fjo_prenom
             		  DISPLAY 'Age du joueur :', fjo_age
             		  DISPLAY 'Ville du joueur :', fjo_ville
             		  DISPLAY 'Nb points du joueur :', fjo_pts
                   END-IF
              END-READ
           END-PERFORM
           CLOSE fjoueurs.





RECHERCHE_JVILLE.

           OPEN Input fjoueurs
           DISPLAY 'Quelle ville ?'
           ACCEPT Wville
           MOVE 0 TO Wfin
           START fjoueurs, KEY IS = fjo_ville
           INVALID KEY DISPLAY 'Aucun joueur trouvé'
           NOT INVALID KEY
               PERFORM WITH TEST AFTER UNTIL Wfin = 1
                   READ fjoueurs NEXT
                   AT END MOVE 1 TO Wfin
                   NOT AT END
                       IF Wville = fjo_ville
                       	DISPLAY 'ID du joueur :', fjo_id
             		  	DISPLAY 'Nom du joueur :', fjo_nom
             		  	DISPLAY 'Prenom du joueur :', fjo_prenom
             		  	DISPLAY 'Age du joueur :', fjo_age
             		  	DISPLAY 'Ville du joueur :', fjo_ville
             		  	DISPLAY 'Nb points du joueur :', fjo_pts
                        ELSE MOVE 1 TO Wfin
                       END-IF
                     end-read
               END-PERFORM
              end-start
           CLOSE fjoueurs.






RECHERCHE_JNBPTS.
	    OPEN Input fjoueurs
           DISPLAY 'Quel nombre de point ?'
           ACCEPT Wpoints
           MOVE 0 TO Wfin
           START fjoueurs, KEY IS = fjo_pts
           INVALID KEY DISPLAY 'Aucun joueur trouvé'
           NOT INVALID KEY
               PERFORM WITH TEST AFTER UNTIL Wfin = 1
                   READ fjoueurs NEXT
                   AT END MOVE 1 TO Wfin
                   NOT AT END
                       IF Wpoints = fjo_pts
                       	DISPLAY 'ID du joueur :', fjo_id
             		  	DISPLAY 'Nom du joueur :', fjo_nom
             		  	DISPLAY 'Prenom du joueur :', fjo_prenom
             		  	DISPLAY 'Age du joueur :', fjo_age
             		  	DISPLAY 'Ville du joueur :', fjo_ville
             		  	DISPLAY 'Nb points du joueur :', fjo_pts
                        ELSE MOVE 1 TO Wfin
                       END-IF
                     END-READ
               END-PERFORM
            end-start
              
           CLOSE fjoueurs.


           RECHERCHE_numpP.

           OPEN Input fparties
           DISPLAY 'Quel est le numéro de la partie ?'
           ACCEPT fpa_numP
           READ fparties NEXT
           INVALID KEY DISPLAY 'Cette partie n existe pas'
           NOT INVALID KEY
               DISPLAY 'Numéro de partie :', fpa_numP
               DISPLAY 'Temps de la partie :', fpa_temps
               DISPLAY 'Type ouverture de la partie :', fpa_type
           end-read
           CLOSE ftournois.

RECHERCHE_partietype.

           OPEN Input fparties
           DISPLAY 'Quel type de partie?'
           ACCEPT WtypeP
           MOVE 0 TO Wfin
           START fparties, KEY IS = fpa_type
           INVALID KEY DISPLAY 'Aucune partie trouvée'
           NOT INVALID KEY
               PERFORM WITH TEST AFTER UNTIL Wfin = 1
                   READ fparties NEXT
                   AT END MOVE 1 TO Wfin
                   NOT AT END
                       IF WtypeP = fpa_type
                        DISPLAY 'Numéro de partie :', fpa_numP
               			DISPLAY 'Temps de la partie :', fpa_temps
              			DISPLAY 'Type ouverture de la partie :', fpa_type
                       ELSE MOVE 1 TO Wfin
                       END-IF
                   END-READ
               END-PERFORM
              end-start
           CLOSE fparties.


RECHERCHE_partietemps.

           OPEN Input fparties
           DISPLAY 'Quel temps pour la partie?'
           ACCEPT WtempsP
           MOVE 0 TO Wfin
           START fparties, KEY IS = fpa_temps
           INVALID KEY DISPLAY 'Aucune partie trouvée'
           NOT INVALID KEY
               PERFORM WITH TEST AFTER UNTIL Wfin = 1
                   READ fparties NEXT
                   AT END MOVE 1 TO Wfin
                   NOT AT END
                       IF WtempsP = fpa_temps
                        DISPLAY 'Numéro de partie :', fpa_numP
               			DISPLAY 'Temps de la partie :', fpa_temps
              			DISPLAY 'Type ouverture de la partie :', fpa_type
                       ELSE MOVE 1 TO Wfin
                       END-IF
                   END-READ
               END-PERFORM
           END-START
           CLOSE fparties.

           RECHERCHE_ID.
           OPEN Input ftournois
           DISPLAY 'Quel est lid du tournoi?'
           ACCEPT fto_id
           READ ftournois NEXT
           INVALID KEY DISPLAY 'Ce tournois nexiste pas'
           NOT INVALID KEY
               DISPLAY 'semaine du tournoi :', fto_sem
               DISPLAY 'Ville du tournoi:', fto_ville
               DISPLAY 'Nombre de places:', fto_nbplaces
               DISPLAY 'rang du tournoi:', fto_rgTour
	             DISPLAY 'ID du tournoi :', fto_id
               DISPLAY 'Type de partie :', fto_typeP
            END-READ
           CLOSE ftournois.


           RECHERCHE_nbplaces.
           OPEN INput ftournois
           DISPLAY 'Quel nombre de places?'
           ACCEPT WnbP
           MOVE 0 TO Wfin
           PERFORM WITH TEST AFTER UNTIL Wfin = 1
               READ ftournois NEXT
               AT END MOVE 1 TO Wfin
               NOT AT END
                   IF WnbP = fto_nbplaces
                       DISPLAY 'Semaine du tournoi:', fto_sem
                       DISPLAY 'Ville du tournoi:', fto_ville
                       DISPLAY 'rang du tournoi:', fto_rgTour
                       DISPLAY 'ID du tournoi :', fto_id
		       DISPLAY 'Type de partie :', fto_typeP
                   END-IF
               END-READ
           END-PERFORM
           CLOSE ftournois.

           RECHERCHE_RANGTOURNOI.
           OPEN INPUT ftournois
           PERFORM WITH TEST AFTER UNTIL fto_rgTour<=3
                     DISPLAY 'Quel rang de tournoi?'
               ACCEPT fto_rgTour
           END-PERFORM
           MOVE 0 TO Wfin
           START ftournois, KEY IS = fto_rgTour
           INVALID KEY DISPLAY 'aucun tournoi trouvé'
           NOT INVALID KEY
               PERFORM WITH TEST AFTER UNTIL Wfin = 1
                   READ ftournois NEXT
                   AT END MOVE 1 TO Wfin
                   NOT AT END
                       IF WrgT = fto_rgTour
                           DISPLAY 'Semaine du tournoi:', fto_sem
                           DISPLAY 'Ville du tournoi:', fto_ville
                           DISPLAY 'Nombre de places:', fto_nbplaces
                           DISPLAY 'ID du tournoi :', fto_id
		           DISPLAY 'Type de partie :', fto_typeP
                       ELSE MOVE 1 TO Wfin
                       END-IF
                     END-READ
               END-PERFORM
           CLOSE ftournois.


           RECHERCHE_SEMAINE.
           OPEN INPUT ftournois
           PERFORM WITH TEST AFTER UNTIL Wsemaine<=53
                     DISPLAY 'Quelle semaine?'
               ACCEPT Wsemaine
           END-PERFORM
           MOVE 0 TO Wtrouve
           MOVE 0 TO Wfin
           PERFORM WITH TEST AFTER UNTIL Wfin = 1 OR Wtrouve = 0
               READ ftournois NEXT
               AT END MOVE 1 TO Wfin
                   DISPLAY 'Aucun tournois pour cette semaine'
               NOT AT END
                   IF Wsemaine = fto_sem
                      MOVE 1 TO Wtrouve
                       DISPLAY 'Ville du tournoi:', fto_ville
                       DISPLAY 'Nombre de places:', fto_nbplaces
                       DISPLAY 'rang du tournoi:', fto_rgTour
		       DISPLAY 'Type de partie :', fto_typeP
                   END-IF
               END-READ
           END-PERFORM

           CLOSE ftournois.


           RECHERCHE_TYPEPARTIE.
           OPEN INPUT ftournois
           DISPLAY 'Quel type de partie?'
           ACCEPT fto_typeP
           MOVE 0 TO Wfin
           START ftournois, KEY IS = fto_typeP
           INVALID KEY DISPLAY 'Aucun tournois trouvé'
           NOT INVALID KEY
           
               PERFORM WITH TEST AFTER UNTIL Wfin = 1
                   READ ftournois NEXT
                   AT END MOVE 1 TO Wfin
                   NOT AT END
                       IF WidP = fto_typeP
                           DISPLAY 'Semaine du tournoi:', fto_sem
                           DISPLAY 'Ville du tournoi:', fto_ville
                           DISPLAY 'Nombre de places:', fto_nbplaces
                           DISPLAY 'ID du tournoi :', fto_id
                           DISPLAY 'Rang du tournoi :', fto_rgTour
                       ELSE MOVE 1 TO Wfin
                       END-IF
                     END-READ
               END-PERFORM
                       
              END-START

           CLOSE ftournois.

           RECHERCHE_VILLE.
           OPEN Input ftournois
           DISPLAY 'Quelle ville?'
           ACCEPT Wville
           MOVE 0 TO Wfin
           PERFORM WITH TEST AFTER UNTIL Wfin = 1
               READ ftournois NEXT
               AT END MOVE 1 TO Wfin
               NOT AT END
                   IF Wville = fto_ville
                       DISPLAY 'Semaine du tournoi:', fto_sem
                       DISPLAY 'Nombre de places:', fto_nbplaces
                       DISPLAY 'rang du tournoi:', fto_rgTour
		       DISPLAY 'Type de partie :', fto_typeP
                   END-IF
                   END-READ
           END-PERFORM
           CLOSE ftournois.




           RECHERCHE_MAX_VAINQ_TOURNOI.
           MOVE 0 TO Wmax
           MOVE 0 TO  Wcompt
           MOVE 0 TO  Wfin
           OPEN INPUT fjoueurs
           PERFORM WITH TEST AFTER UNTIL Wfin = 1
               READ fjoueurs NEXT
               AT END MOVE 1 TO Wfin
               NOT AT END
                     OPEN INPUT ftournois
                      MOVE 0 TO Wfin2
                      PERFORM WITH TEST AFTER UNTIL Wfin2 = 1
                            READ ftournois NEXT
                              AT END MOVE 1 TO Wfin
                              NOT AT END
                                          OPEN INPUT fderoulement
                                          MOVE 0 TO Wfin3
                                          MOVE 0 TO WdejaInscrit
                                          MOVE 0 TO Wfdz
                                          STRING WidT'-'fto_ntours INTO fder_touridT
                                          MOVE fder_touridT TO WtouridT
                                          START fderoulement KEY IS = fder_touridT
                                          INVALID KEY MOVE 1 TO Wbeug
                                          NOT INVALID KEY
                                                 PERFORM WITH TEST AFTER UNTIL Wfin3 = 1 OR Wfdz =1
                                                        READ fderoulement NEXT
                                                               AT END
                                                                      MOVE 1 TO Wfin3
                                                               NOT AT END
                                                                      IF fder_touridT IS = WtouridT THEN
                                                                          IF fder_idV = fjo_id then
                                                                             COMPUTE Wcompt = Wcompt + 1
                                                                           END-IF
                                                                             
                                                                      ELSE
                                                                             MOVE 1 TO Wfdz
                                                                      END-IF
                                                        END-READ
                                                 END-PERFORM
                                          END-START
                                          CLOSE fderoulement
                            
                      
                               END-READ
                       END-PERFORM
                       CLOSE ftournois
                END-READ
              IF Wmax< Wcompt THEN 
                     move Wcompt TO Wmax
                     MOVE fjo_id TO Wid
             END-PERFORM
              
          DISPLAY 'Le joueur qui a gagne le plus de tournoi est le joueur id = ' Wid
          display 'Ce joueur a gagne' Wmax 'tournois'
       
          CLOSE fjoueurs.


       AFFICHE_VAINQUEUR.

PERFORM WITH TEST AFTER UNTIL Wtrouve = 0
       DISPLAY 'Donnez id du tournoi '
       PERFORM AFFICH_TOURNOI
       ACCEPT WidT
       PERFORM TOURNOI_EXIST
END-PERFORM
OPEN INPUT fderoulement
MOVE 0 TO Wfin
MOVE 0 TO WdejaInscrit
MOVE 0 TO Wfdz
STRING WidT'-'Wtour INTO fder_touridT
MOVE fder_touridT TO WtouridT
START fderoulement KEY IS = fder_touridT
INVALID KEY MOVE DISPLAY 'Tournoi pas termine'
NOT INVALID KEY
PERFORM WITH TEST AFTER UNTIL Wfin = 1 OR WdejaInscrit = 1 or Wfdz =1
       READ fderoulement NEXT
              AT END
                     MOVE 1 TO Wfin
       NOT AT END
       IF fder_touridT IS = WtouridT THEN
              DISPLAY 'Le joueur vainqueur du tournoi est ' fder_idV

       ELSE
              MOVE 1 TO Wfdz
       END-IF
       END-READ
END-PERFORM
END-START



       







            
