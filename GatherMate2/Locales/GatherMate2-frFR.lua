-- GatherMate Locale
-- Please use the Localization App on WoWAce to Update this
-- http://www.wowace.com/projects/gathermate2/localization

local L = LibStub("AceLocale-3.0"):NewLocale("GatherMate2", "frFR")
if not L then return end

L["Add this location to Cartographer_Waypoints"] = "Ajouter cette position à Cartographer_Waypoints"
L["Add this location to TomTom waypoints"] = "Ajouter cette position aux points de navigation de TomTom"
L["Always show"] = "Toujours afficher"
L["Archaeology"] = "Archéologie"
L["Archaeology filter"] = "Filtre de l'archéologie"
L["Are you sure you want to delete all nodes from this database?"] = "Êtes-vous sûr de vouloir supprimer tous les nœuds de cette base de données ?"
L["Are you sure you want to delete all of the selected node from the selected zone?"] = "Êtes-vous sûr de vouloir supprimer tous les nœuds sélectionnés de la zone sélectionnée ?"
L["Auto Import"] = "Importation auto."
L["Auto import complete for addon "] = "Importation automatique terminée pour l'addon "
L["Automatically import when ever you update your data module, your current import choice will be used."] = "Importe automatiquement quand vous mettez à jour votre module de données, en utilisant votre type d'importation actuel."
L["Cataclysm"] = "Cataclysm"
L["Cleanup Complete."] = "Nettoyage terminé."
L["Cleanup Database"] = "Nettoyer la base"
L["Cleanup_Desc"] = "Au fil du temps, votre base de données risque de devenir surchargée. Nettoyer votre base de données permet de vérifier les nœuds du même type de métier qui sont très proches les uns des autres et de déterminer s'il faut les rassembler en un seul nœud ou non."
L["Cleanup Failed."] = "Échec du nettoyage." -- Needs review
L["Cleanup in progress."] = "Nettoyage en cours." -- Needs review
L["Cleanup radius"] = "Rayon de nettoyage"
L["CLEANUP_RADIUS_DESC"] = "Le rayon en mètres où les nœuds dupliqués doivent être enlevés. La valeur par défaut est de |cffffd20050|r mètres pour l'extraction de gaz et de |cffffd20015|r mètres pour tout le reste. Ces paramètres sont également utilisés lors de l'ajout de nœuds."
L["Cleanup Started."] = "Nettoyage initié." -- Needs review
L["Cleanup your database by removing duplicates. This takes a few moments, be patient."] = "Nettoye votre base de données en enlevant les doublons. Ceci peut prendre un petit moment, soyez patient."
L["Clear database selections"] = "Effacer la sélection des bases"
L["Clear node selections"] = "Efface toute sélection de nœud."
L["Clear zone selections"] = "Effacer la sélection des zones"
L["Click to toggle minimap icons."] = "Cliquez pour afficher/cacher les icônes de la minicarte." -- Needs review
L["Color of the tracking circle."] = "Détermine la couleur du cercle de suivi."
L["Control various aspects of node icons on both the World Map and Minimap."] = "Contrôle divers aspects des icônes des nœuds affichés sur la carte du monde et la minicarte."
L["Conversion_Desc"] = "Convertit les données existantes de GatherMate au format GatherMate2."
L["Convert Databses"] = "Conversion des bases de données"
L["Database locking"] = "Verrouille cette base de données si cochée."
L["Database Locking"] = "Verrouillage des bases de données"
L["DATABASE_LOCKING_DESC"] = "Le verrouillage de base de données vous permet de figer l'état d'une base de données. Une fois verrouillée, il vous est impossible d'ajouter, de supprimer ou de modifier la base de données en question. Cela comprend le nettoyage et les importations."
L["Database Maintenance"] = "Maintenance BdD"
L["Databases to Import"] = "Bases de données à importer"
L["Databases you wish to import"] = "Bases de données que vous souhaitez importer."
L["Delete"] = "Supprimer"
L["Delete Entire Database"] = "Supprimer toute la base de données"
L["DELETE_ENTIRE_DESC"] = "Ceci ignorera le Verrouillage des bases de données et enlèvera tous les nœuds de toutes les zones de la base de données sélectionnée."
L["Delete selected node from selected zone"] = "Supprime les nœuds sélectionnés de la zone sélectionnée"
L["DELETE_SPECIFIC_DESC"] = "Supprime tous les nœuds sélectionnés de la zone sélectionnée. Vous devez désactiver le Verrouillage des bases de données pour que ceci fonctionne."
L["Delete Specific Nodes"] = "Supprimer des nœuds spécifiques"
L["Disabled"] = "Désactivées" -- Needs review
L["Display Settings"] = "Affichage"
L["Enabled"] = "Activées" -- Needs review
L["Engineering"] = "Ingénierie"
L["Expansion"] = "Extension"
L["Expansion Data Only"] = "Extension uniquement"
L["Failed to load GatherMateData due to "] = "Échec du chargement de GatherMateData suite à "
L["FAQ"] = "FAQ"
L["FAQ_TEXT"] = [=[|cffffd200
Je viens juste d'installer GatherMate, mais je ne vois aucun nœud sur mes cartes !
|r
GatherMate ne contient aucune donnée en l'état. Quand vous récoltez des herbes, des minerais, des gaz ou des poissons, GatherMate ajoutera et mettra à jour votre carte en conséquence. De plus, vérifiez vos paramètres d'affichage.

|cffffd200
Je vois des nœuds sur ma carte du monde mais pas sur ma minicarte !
|r
|cffffff78Minimap Button Bag|r (et sans doute d'autres addons similaires) aime phagocyter tous les boutons que nous plaçons sur la minicarte. Désactivez-le.

|cffffd200
Comment ou où puis-je obtenir des données déjà existantes ?
|r
Vous pouvez importer des données déjà existantes dans GatherMate des façons suivantes :

1. |cffffff78GatherMate_Data|r - Cet addon LoD (chargeable à la demande) contient des données extraites de WowHead de tous les nœuds et est mis à jour toutes les semaines. Il y a des options de mise à jour automatique.

2. |cffffff78GatherMate_CartImport|r - Cet addon vous permet d'importer vos bases de données des modules |cffffff78Cartographer_<Métier>|r dans GatherMate. Pour que cela fonctionne, le(s) module(s) |cffffff78Cartographer_<Métier>|r et GatherMate_CartImport doivent être chargés et activés.

Notez que l'importation de données dans GatherMate n'est pas un processus automatique. Vous devez aller dans la section "Importation données" et cliquer sur le bouton "Importer".

La différence avec |cffffff78Cartographer_Data|r est que l'utilisateur a le choix de la façon dont (et du moment où) les données sont modifiées. |cffffff78Cartographer_Data|r, une fois chargé, écrase simplement vos bases de données existantes sans avertissement et détruit tous les nouveaux nœuds que vous avez trouvé.

|cffffd200
Pouvez-vous ajouter le support de l'affichage des positions de choses telles que les boîtes aux lettres et les maîtres de vol ?
|r
À nouveau, la réponse est non. Cependant, un autre auteur a le droit de créer un addon ou un module à cet effet. Le cœur de l'addon GatherMate ne le fera jamais.

|cffffd200
J'ai trouvé un bogue ! Où puis-je le signaler ?
|r
Vous pouvez signaler des bogues ou faire des suggestions sur |cffffff78http://www.wowace.com/forums/index.php?topic=10990.0|r

Vous pouvez également nous trouver sur |cffffff78irc://irc.freenode.org/wowace|r

Quand vous voulez signaler un bogue, essayez de fournir les |cffffff78étapes à suivre pour reproduire ce bogue|r, indiquez les |cffffff78messages d'erreur|r que vous avez vus, donnez le |cffffff78numéro de révision|r de GatherMate où le problème a été découvert et précisez également la |cffffff78langue de votre jeu|r.

|cffffd200
Qui a écrit cet addon qui déchire ?
|r
Kagaro, Xinhuan, Nevcairiel et Ammo.]=]
L["Filter_Desc"] = "Sélectionnez les types de nœuds que vous souhaitez voir affichés sur la carte du monde et la minicarte. Les types de nœuds non sélectionnés continueront cependant à être enregistrés dans la base de données."
L["Filters"] = "Filtres"
L["Fishes"] = "Poissons"
L["Fish filter"] = "Filtre des poissons"
L["Fishing"] = "Pêche"
L["Frequently Asked Questions"] = "Foire aux questions"
L["Gas Clouds"] = "Nuages de gaz"
L["Gas filter"] = "Filtre des gaz"
L["GatherMate2Data has been imported."] = "GatherMate2Data a été importé."
L["GatherMate Conversion"] = "Conversion de GatherMate"
L["GatherMate data has been imported."] = "Les données de GatherMate ont été importées."
L["GatherMateData has been imported."] = "GatherMateData a été importé."
L["GatherMate Pin Options"] = "Options des points GatherMate"
L["General"] = "Général"
L["Herbalism"] = "Herboristerie"
L["Herb Bushes"] = "Buissons d'herbe"
L["Herb filter"] = "Filtre des herbes"
L["Icon Alpha"] = "Transparence des icônes"
L["Icon alpha value, this lets you change the transparency of the icons. Only applies on World Map."] = "Permet de changer la valeur de transparence des icônes. S'applique uniquement à la carte du monde."
L["Icons"] = "Icônes"
L["Icon Scale"] = "Échelle des icônes"
L["Icon scaling, this lets you enlarge or shrink your icons on both the World Map and Minimap."] = "Permet d'agrandir ou de rétrécir les icônes affichées sur la carte du monde et la minicarte."
L["Icon scaling, this lets you enlarge or shrink your icons on the Minimap."] = "Échelle des icônes - vous permet d'agrandir ou de réduire vos icônes sur la minicarte." -- Needs review
L["Icon scaling, this lets you enlarge or shrink your icons on the World Map."] = "Échelle des icônes - vous permet d'agrandir ou de réduire vos icônes sur la carte du monde." -- Needs review
L["Import Data"] = "Importation données"
L["Import GatherMate2Data"] = "Importer GatherMate2Data"
L["Import GatherMateData"] = "Importer GatherMateData"
L["Importing_Desc"] = "L'importation permet à GatherMate d'obtenir de nouveau nœuds à partir de sources autres que vos propres récoltes dans le jeu. Après avoir importé des données, il est conseillé d'effectuer un nettoyage de la base de données."
L["Import Options"] = "Options d'importation"
L["Import Style"] = "Type d'importation"
L["Keybind to toggle Minimap Icons"] = "Raccourci pour afficher/masquer les icônes"
L["Keybind to toggle Worldmap Icons"] = "Raccourci pour activer les icônes sur la carte du monde" -- Needs review
L["Load GatherMate2Data and import the data to your database."] = "Charge GatherMate2Data et importe les données dans votre base de données."
L["Load GatherMateData and import the data to your database."] = "Charge GatherMate_Data et importe ses données dans votre base de données."
L["Merge"] = "Fusionner"
L["Merge will add GatherMate2Data to your database. Overwrite will replace your database with the data in GatherMate2Data"] = "La fusion ajoutera GatherMate2Data dans votre base de données. L'écrasement remplacera votre base de données par les données contenues dans GatherMate2Data."
L["Merge will add GatherMateData to your database. Overwrite will replace your database with the data in GatherMateData"] = "La fusion ajoutera GatherMateData dans votre base de données. L'écrasement remplacera votre base de données par les données contenues dans GatherMateData."
L["Mine filter"] = "Filtre des mines"
L["Mineral Veins"] = "Veines de minerai"
L["Minimap Icons"] = "Icônes de la minicarte" -- Needs review
L["Minimap Icon Scale"] = "Échelle des icônes de la minicarte" -- Needs review
L["Minimap Icon Tooltips"] = "Bulles d'aide minicarte"
L["Mining"] = "Minage"
L["Mists of Pandaria"] = "Mists of Pandaria" -- Needs review
L["Never show"] = "Ne jamais afficher"
L["Only import selected expansion data from WoWDB"] = "Importe uniquement les données de WoWDB de l'extension sélectionnée."
L["Only import selected expansion data from WoWhead"] = "Importe uniquement les données des expansions sélectionnées à partir de WowHead."
L["Only while tracking"] = "Si le suivi est activé"
L["Only with digsite"] = "Si site de fouilles"
L["Only with profession"] = "Si j'ai le métier"
L["Overwrite"] = "Écraser"
L["Processing "] = "Traitement de "
L["Right-click for options."] = "Clic droit pour les options." -- Needs review
L["Select All"] = "Tout sélectionner"
L["Select all databases"] = "Sélection de les bases de données"
L["Select all nodes"] = "Sélectionne tous les nœuds."
L["Select all zones"] = "Sélection de outes les zones"
L["Select Database"] = "Sélection de la base"
L["Select Databases"] = "Sélection des bases de données"
L["Selected databases are shown on both the World Map and Minimap."] = "Les bases de données sélectionnées sont affichées sur la carte du monde et la minicarte."
L["Select Node"] = "Sélection des nœuds"
L["Select None"] = "Ne rien sélectionner"
L["Select the archaeology nodes you wish to display."] = "Sélectionnez les nœuds d'archéologie que vous souhaitez afficher."
L["Select the fish nodes you wish to display."] = "Sélectionnez les nœuds de pêche que vous souhaitez afficher."
L["Select the gas clouds you wish to display."] = "Sélectionnez les nuages de gaz que vous souhaitez afficher."
L["Select the herb nodes you wish to display."] = "Sélectionnez les nœuds d'herboristerie que vous souhaitez afficher."
L["Select the mining nodes you wish to display."] = "Sélectionnez les nœuds de minage que vous souhaitez afficher."
L["Select the treasure you wish to display."] = "Sélectionnez les nœuds de trésor que vous souhaitez afficher."
L["Select Zone"] = "Sélection de la zone"
L["Select Zones"] = "Sélection des zones"
L["Shift-click to toggle world map icons."] = "Shift-clic pour afficher/cacher les icônes de la carte du monde." -- Needs review
L["Show Archaeology Nodes"] = "Nœuds d'archéologie"
L["Show Databases"] = "Bases de données à afficher"
L["Show Fishing Nodes"] = "Nœuds de pêche"
L["Show Gas Clouds"] = "Nuages de gaz"
L["Show Herbalism Nodes"] = "Nœuds d'herboristerie"
L["Show Minimap Icons"] = "Icônes sur la minicarte"
L["Show Mining Nodes"] = "Nœuds de minage"
L["Show Nodes on Minimap Border"] = "Afficher les nœuds sur les bords de la minicarte"
L["Shows more Nodes that are currently out of range on the minimap's border."] = "Affiche les nœuds qui sont actuellement hors de portée sur les bords de la minicarte."
L["Show Timber Nodes"] = "Nœuds de bois" -- Needs review
L["Show Tracking Circle"] = "Affichage du cercle de suivi"
L["Show Treasure Nodes"] = "Nœuds de trésor"
L["Show World Map Icons"] = "Icônes carte du monde"
L["The Burning Crusades"] = "Burning Crusade"
L["The distance in yards to a node before it turns into a tracking circle"] = "Détermine la distance en mètres entre vous et le nœud avant que ce dernier ne se transforme en cercle de suivi."
L["The Frozen Sea"] = "La mer Gelée"
L["The North Sea"] = "La mer Boréale"
L["Toggle showing archaeology nodes."] = "Affiche ou non les nœuds d'archéologie."
L["Toggle showing fishing nodes."] = "Affiche ou non les nœuds de pêche."
L["Toggle showing gas clouds."] = "Affiche ou non les nuages de gaz."
L["Toggle showing herbalism nodes."] = "Affiche ou non les nœuds d'herboristerie."
L["Toggle showing Minimap icons."] = "Affiche ou non les icônes sur la minicarte."
L["Toggle showing Minimap icon tooltips."] = "Affiche ou non les bulles d'aide des icônes de la minicarte."
L["Toggle showing mining nodes."] = "Affiche ou non les nœuds de minage"
L["Toggle showing the tracking circle."] = "Affiche ou non le cercle de suivi."
L["Toggle showing timber nodes."] = "Affiche ou non les nœuds de bois." -- Needs review
L["Toggle showing treasure nodes."] = "Affiche ou non les nœuds de trésor."
L["Toggle showing World Map icons."] = "Affiche ou non les icônes sur la carte du monde."
L["Tracking Circle Color"] = "Couleur du cercle de suivi"
L["Tracking Distance"] = "Distance de suivi"
L["Treasure"] = "Trésors"
L["Treasure filter"] = "Filtre des trésors"
-- L["Warlords of Draenor"] = "Warlords of Draenor"
L["World Map Icons"] = "Icônes de la carte du monde" -- Needs review
L["World Map Icon Scale"] = "Échelle des icônes de la carte du monde" -- Needs review
L["Wrath of the Lich King"] = "Wrath of the Lich King"


local NL = LibStub("AceLocale-3.0"):NewLocale("GatherMate2Nodes", "frFR")
if not NL then return end

NL["Abundant Bloodsail Wreckage"] = "Débris abondants de la Voile sanglante"
NL["Abundant Firefin Snapper School"] = "Banc abondant de lutjans de nagefeu"
NL["Abundant Oily Blackmouth School"] = "Banc abondant de bouches-noires huileux"
NL["Abyssal Gulper School"] = "Banc de grangousiers des abysses" -- Needs review
NL["Adamantite Bound Chest"] = "Coffre cerclé d'adamantite"
NL["Adamantite Deposit"] = "Gisement d'adamantite"
NL["Adder's Tongue"] = "Langue de serpent"
NL["Albino Cavefish School"] = "Banc de tétras cavernicoles albinos"
NL["Algaefin Rockfish School"] = "Banc de sébastes nagealgue"
NL["Ancient Lichen"] = "Lichen ancien"
NL["Arakkoa Archaeology Find"] = "Trouvaille archéologique arakkoa"
NL["Arcane Vortex"] = "Vortex arcanique"
NL["Arctic Cloud"] = "Nuage arctique"
NL["Arthas' Tears"] = "Larmes d'Arthas"
NL["Azshara's Veil"] = "Voile d'Azshara"
NL["Battered Chest"] = "Coffre endommagé"
NL["Battered Footlocker"] = "Cantine endommagée"
NL["Blackbelly Mudfish School"] = "Banc d'éperlans ventre-noir"
NL["Black Lotus"] = "Lotus noir"
NL["Blackrock Deposit"] = "Gisement de rochenoire" -- Needs review
NL["Black Trillium Deposit"] = "Gisement de trillium noir" -- Needs review
NL["Blackwater Whiptail School"] = "Banc de hokis des flots noirs" -- Needs review
NL["Blind Lake Sturgeon School"] = "Banc d’esturgeons jaunes aveugles" -- Needs review
NL["Blindweed"] = "Aveuglette"
NL["Blood of Heroes"] = "Sang des héros"
NL["Bloodpetal Sprout"] = "Pousse de Pétale-de-sang"
NL["Bloodsail Wreckage"] = "Débris de la Voile sanglante"
NL["Bloodsail Wreckage Pool"] = "Débris de la Voile sanglante" -- Needs review
NL["Bloodthistle"] = "Chardon sanglant"
NL["Bloodvine"] = "Vignesang"
NL["Bluefish School"] = "Banc de tassergals"
NL["Borean Man O' War School"] = "Banc de poissons-méduses boréens"
NL["Bound Adamantite Chest"] = "Coffre cerclé d'adamantite"
NL["Bound Fel Iron Chest"] = "Coffre cerclé de gangrefer"
NL["Brackish Mixed School"] = "Banc mixte en eaux saumâtres"
NL["Briarthorn"] = "Eglantine"
NL["Brightly Colored Egg"] = "Oeuf vivement coloré"
NL["Bruiseweed"] = "Doulourante"
NL["Buccaneer's Strongbox"] = "Coffre des boucaniers"
NL["Burial Chest"] = "Coffre funéraire"
NL["Cinderbloom"] = "Cendrelle"
NL["Cinder Cloud"] = "Nuage de braise"
NL["Cobalt Deposit"] = "Gisement de cobalt"
NL["Copper Vein"] = "Filon de cuivre"
NL["Dark Iron Deposit"] = "Gisement de sombrefer"
NL["Dark Iron Treasure Chest"] = "Coffre en sombrefer"
NL["Dark Soil"] = "Terre sombre" -- Needs review
NL["Dart's Nest"] = "Œuf de Flèche" -- Needs review
NL["Deep Sea Monsterbelly School"] = "Banc de baudroies abyssales"
NL["Deepsea Sagefish School"] = "Banc de sagerelles abyssales"
NL["Dented Footlocker"] = "Cantine abîmée"
NL["Draenei Archaeology Find"] = "Trouvaille archéologique draeneï"
NL["Draenor Clans Archaeology Find"] = "Trouvaille archéologique des clans de Draenor"
NL["Dragonfin Angelfish School"] = "Banc de demoiselles aileron-de-dragon"
NL["Dragon's Teeth"] = "Dents de dragon"
NL["Dreamfoil"] = "Feuillerêve"
NL["Dreaming Glory"] = "Glaurier"
NL["Dwarf Archaeology Find"] = "Trouvaille archéologique naine"
NL["Earthroot"] = "Terrestrine"
NL["Elementium Vein"] = "Filon d'élémentium"
NL["Emperor Salmon School"] = "Banc de saumons empereurs"
NL["Everfrost Chip"] = "Morceau de permagivre"
NL["Fadeleaf"] = "Pâlerette"
NL["Fangtooth Herring School"] = "Banc de harengs crocs-pointus"
NL["Fathom Eel Swarm"] = "Banc d'anguilles des profondeurs"
NL["Fat Sleeper School"] = "Banc de dormeurs tachetés" -- Needs review
NL["Fel Iron Chest"] = "Coffre en gangrefer"
NL["Fel Iron Deposit"] = "Gisement de gangrefer"
NL["Felmist"] = "Gangrebrume"
NL["Felsteel Chest"] = "Coffre en gangracier"
NL["Feltail School"] = "Banc de gangre-queues"
NL["Felweed"] = "Gangrelette"
NL["Fire Ammonite School"] = "Banc d’ammonites de feu" -- Needs review
NL["Firebloom"] = "Fleur de feu"
NL["Firefin Snapper School"] = "Banc de lutjans de nagefeu"
NL["Firethorn"] = "Epine de feu"
NL["Fireweed"] = "Ignescente" -- Needs review
NL["Flame Cap"] = "Chapeflamme"
NL["Floating Debris"] = "Débris flottant"
NL["Floating Debris Pool"] = "Débris flottants" -- Needs review
-- NL["Floating Shipwreck Debris"] = "Floating Shipwreck Debris"
NL["Floating Wreckage"] = "Débris flottants"
NL["Floating Wreckage Pool"] = "Déchets flottants"
NL["Fool's Cap"] = "Berluette" -- Needs review
NL["Fossil Archaeology Find"] = "Trouvaille archéologique fossile"
NL["Frost Lotus"] = "Lotus givré"
NL["Frostweed"] = "Givrelette" -- Needs review
NL["Frozen Herb"] = "Herbe gelée"
NL["Ghost Iron Deposit"] = "Gisement d’ectofer"
NL["Ghost Mushroom"] = "Champignon fantôme"
NL["Giant Clam"] = "Palourde géante"
NL["Giant Mantis Shrimp Swarm"] = "Banc de crevettes-mantes géantes"
NL["Glacial Salmon School"] = "Banc de saumons glaciaires"
NL["Glassfin Minnow School"] = "Banc de vairons nageverres"
NL["Glowcap"] = "Chapeluisant"
NL["Goldclover"] = "Trèfle doré"
NL["Golden Carp School"] = "Banc de carpes dorées"
NL["Golden Lotus"] = "Lotus doré"
NL["Golden Sansam"] = "Sansam doré"
NL["Goldthorn"] = "Dorépine"
NL["Gold Vein"] = "Filon d'or"
NL["Gorgrond Flytrap"] = "Dionée de Gorgrond" -- Needs review
NL["Grave Moss"] = "Tombeline"
NL["Greater Sagefish School"] = "Banc de grandes sagerelles"
NL["Green Tea Leaf"] = "Feuille de thé vert" -- Needs review
NL["Gromsblood"] = "Gromsang"
NL["Heartblossom"] = "Pétale de cœur"
NL["Heavy Fel Iron Chest"] = "Coffre lourd en gangrefer"
NL["Highland Guppy School"] = "Banc de guppys des Hautes terres"
NL["Highland Mixed School"] = "Banc mixte des Hautes-terres"
NL["Huge Obsidian Slab"] = "Enorme bloc d'obsidienne"
NL["Icecap"] = "Calot de glace"
NL["Icethorn"] = "Glacépine"
NL["Imperial Manta Ray School"] = "Banc de raies manta impériales"
NL["Incendicite Mineral Vein"] = "Filon d'incendicite"
NL["Indurium Mineral Vein"] = "Filon d'indurium"
NL["Iron Deposit"] = "Gisement de fer"
NL["Jade Lungfish School"] = "Banc de dipneustes de jade"
NL["Jawless Skulker School"] = "Banc de furtifs agnathes" -- Needs review
NL["Jewel Danio School"] = "Banc de danios joyaux" -- Needs review
NL["Khadgar's Whisker"] = "Moustache de Khadgar"
NL["Khorium Vein"] = "Filon de khorium"
NL["Kingsblood"] = "Sang-royal"
NL["Krasarang Paddlefish School"] = "Banc de poissons-spatules de Krasarang"
NL["Kyparite Deposit"] = "Gisement de kyparite" -- Needs review
NL["Lagoon Pool"] = "Bassin du lagon" -- Needs review
NL["Large Battered Chest"] = "Grand coffre endommagé"
NL["Large Darkwood Chest"] = "Grand coffre de sombrebois"
NL["Large Iron Bound Chest"] = "Grand coffre cerclé de fer"
NL["Large Mithril Bound Chest"] = "Grand coffre cerclé de mithril"
NL["Large Obsidian Chunk"] = "Grand morceau d'obsidienne"
NL["Large Solid Chest"] = "Grand coffre solide"
NL["Large Timber"] = "Grand arbre" -- Needs review
NL["Lesser Bloodstone Deposit"] = "Gisement de pierre de sang inférieure"
NL["Lesser Firefin Snapper School"] = "Banc clairsemé de lutjans de nagefeu"
NL["Lesser Floating Debris"] = "Débris flottants inférieurs"
NL["Lesser Oily Blackmouth School"] = "Petit banc de bouches-noires huileux"
NL["Lesser Sagefish School"] = "Petit banc de sagerelles"
NL["Lichbloom"] = "Fleur-de-liche"
NL["Liferoot"] = "Vietérule"
NL["Lumber Mill"] = "Scierie" -- Needs review
NL["Mageroyal"] = "Mage royal"
NL["Mana Thistle"] = "Chardon de mana"
NL["Mantid Archaeology Find"] = "Trouvaille archéologique mantide" -- Needs review
NL["Maplewood Treasure Chest"] = "Coffre en bois d'érable"
NL["Mithril Deposit"] = "Gisement de mithril"
NL["Mogu Archaeology Find"] = "Trouvaille archéologique mogu" -- Needs review
NL["Moonglow Cuttlefish School"] = "Banc de seiches lueur-de-lune"
NL["Mossy Footlocker"] = "Cantine moisie"
NL["Mountain Silversage"] = "Sauge-argent des montagnes"
NL["Mountain Trout School"] = "Banc de truites de montagne"
NL["Muddy Churning Water"] = "Eaux troubles et agitées"
NL["Mudfish School"] = "Banc d'éperlans"
NL["Musselback Sculpin School"] = "Banc de rascasses dos-de-moule"
NL["Mysterious Camel Figurine"] = "Figurine de dromadaire mystérieuse"
NL["Nagrand Arrowbloom"] = "Sagittaire de Nagrand" -- Needs review
NL["Nerubian Archaeology Find"] = "Trouvaille archéologique nérubienne"
NL["Netherbloom"] = "Néantine"
NL["Nethercite Deposit"] = "Gisement de néanticite"
NL["Netherdust Bush"] = "Buisson de pruinéante"
NL["Netherwing Egg"] = "Oeuf de l'Aile-du-Néant"
NL["Nettlefish School"] = "Banc de méduses"
NL["Night Elf Archaeology Find"] = "Trouvaille archéologique elfe de la nuit"
NL["Nightmare Vine"] = "Cauchemardelle"
NL["Obsidian Chunk"] = "Morceau d'obsidienne"
NL["Obsidium Deposit"] = "Gisement d'obsidium"
NL["Ogre Archaeology Find"] = "Trouvaille archéologique ogre"
NL["Oil Spill"] = "Nappe de pétrole"
NL["Oily Abyssal Gulper School"] = "Banc de grangousiers des abysses huileux" -- Needs review
NL["Oily Blackmouth School"] = "Banc de bouches-noires huileux"
NL["Oily Sea Scorpion School"] = "Banc de scorpions de mer huileux"
NL["Onyx Egg"] = "Œuf d’onyx" -- Needs review
NL["Ooze Covered Gold Vein"] = "Filon d'or couvert de limon"
NL["Ooze Covered Mithril Deposit"] = "Gisement de mithril couvert de vase"
NL["Ooze Covered Rich Thorium Vein"] = "Riche filon de thorium couvert de limon"
NL["Ooze Covered Silver Vein"] = "Filon d'argent couvert de limon"
NL["Ooze Covered Thorium Vein"] = "Filon de thorium couvert de limon"
NL["Ooze Covered Truesilver Deposit"] = "Gisement de vrai-argent couvert de vase"
NL["Orc Archaeology Find"] = "Trouvaille archéologique orque"
NL["Other Archaeology Find"] = "Autre trouvaille archéologique"
NL["Pandaren Archaeology Find"] = "Trouvaille archéologique pandarène" -- Needs review
NL["Patch of Elemental Water"] = "Remous d'eau élémentaire"
NL["Peacebloom"] = "Pacifique"
NL["Plaguebloom"] = "Chagrinelle"
NL["Pool of Fire"] = "Flaque de feu"
NL["Practice Lockbox"] = "Coffret d'apprentissage"
NL["Primitive Chest"] = "Coffre primitif"
NL["Pure Saronite Deposit"] = "Gisement de saronite pure"
NL["Pure Water"] = "Eau pure"
NL["Purple Lotus"] = "Lotus pourpre"
NL["Pyrite Deposit"] = "Gisement de pyrite"
NL["Ragveil"] = "Voile-misère"
NL["Rain Poppy"] = "Pavot de pluie" -- Needs review
NL["Ravasaur Matriarch's Nest"] = "Œuf de matriarche ravasaure" -- Needs review
NL["Razormaw Matriarch's Nest"] = "Œuf de matriarche tranchegueule" -- Needs review
NL["Redbelly Mandarin School"] = "Banc de mandarins ventre-rouge"
NL["Reef Octopus Swarm"] = "Banc de poulpes des récifs"
NL["Rich Adamantite Deposit"] = "Riche gisement d'adamantite"
NL["Rich Blackrock Deposit"] = "Riche gisement de rochenoire" -- Needs review
NL["Rich Cobalt Deposit"] = "Riche gisement de cobalt"
NL["Rich Elementium Vein"] = "Riche filon d'élémentium"
NL["Rich Ghost Iron Deposit"] = "Riche gisement d’ectofer"
NL["Rich Kyparite Deposit"] = "Riche gisement de kyparite" -- Needs review
NL["Rich Obsidium Deposit"] = "Riche gisement d'obsidienne"
NL["Rich Pyrite Deposit"] = "Riche gisement de pyrite"
NL["Rich Saronite Deposit"] = "Riche gisement de saronite"
NL["Rich Thorium Vein"] = "Riche filon de thorium"
NL["Rich Trillium Vein"] = "Riche filon de trillium" -- Needs review
NL["Rich True Iron Deposit"] = "Riche gisement de vérifer" -- Needs review
NL["Runestone Treasure Chest"] = "Coffre en pierre runique"
NL["Sagefish School"] = "Banc de sagerelles"
NL["Saronite Deposit"] = "Gisement de saronite"
NL["Savage Piranha Pool"] = "Bassin de piranhas sauvages"
NL["Scarlet Footlocker"] = "Cantine écarlate"
NL["School of Darter"] = "Banc de dards"
NL["School of Deviate Fish"] = "Banc de poissons déviants"
NL["School of Tastyfish"] = "Banc de courbines"
NL["Schooner Wreckage"] = "Débris de goélette"
NL["Schooner Wreckage Pool"] = "Débris de goélette" -- Needs review
NL["Sea Scorpion School"] = "Banc de scorpions de mer"
NL["Sha-Touched Herb"] = "Plante touchée par les sha" -- Needs review
NL["Shipwreck Debris"] = "Débris d'épave"
NL["Silken Treasure Chest"] = "Coffre de soie"
NL["Silkweed"] = "Herbe à soie" -- Needs review
NL["Silverbound Treasure Chest"] = "Coffre lié d'argent"
NL["Silverleaf"] = "Feuillargent"
NL["Silver Vein"] = "Filon d'argent"
NL["Small Obsidian Chunk"] = "Petit morceau d'obsidienne"
NL["Small Thorium Vein"] = "Petit filon de thorium"
NL["Small Timber"] = "Petit arbre" -- Needs review
NL["Snow Lily"] = "Lys des neiges" -- Needs review
NL["Solid Chest"] = "Coffre solide"
NL["Solid Fel Iron Chest"] = "Coffre solide en gangrefer"
NL["Sorrowmoss"] = "Chagrinelle"
NL["Sparkling Pool"] = "Bassin étincelant" -- Needs review
NL["Sparse Firefin Snapper School"] = "Banc épars de lutjans de nagefeu"
NL["Sparse Oily Blackmouth School"] = "Banc clairsemé de bouches-noires huileux"
NL["Sparse Schooner Wreckage"] = "Débris clairsemés de goélette"
NL["Spinefish School"] = "Banc de poissons-hérissons" -- Needs review
NL["Sporefish School"] = "Banc de poissons-spores"
NL["Starflower"] = "Bourrache" -- Needs review
NL["Steam Cloud"] = "Nuage de vapeur"
NL["Steam Pump Flotsam"] = "Détritus de la pompe à vapeur"
NL["Stonescale Eel Swarm"] = "Banc d'anguilles pierre-écaille"
NL["Stormvine"] = "Vignétincelle"
NL["Strange Pool"] = "Bassin étrange"
NL["Stranglekelp"] = "Etouffante"
NL["Sturdy Treasure Chest"] = "Coffre solide"
NL["Sungrass"] = "Soleillette"
NL["Swamp Gas"] = "Gaz des marais"
NL["Takk's Nest"] = "Œuf de Takk" -- Needs review
NL["Talador Orchid"] = "Orchidée de Talador" -- Needs review
NL["Talandra's Rose"] = "Rose de Talandra"
NL["Tattered Chest"] = "Coffre en morceaux"
NL["Teeming Firefin Snapper School"] = "Banc grouillant de lutjans de nagefeu"
NL["Teeming Floating Wreckage"] = "Débris flottants grouillants"
NL["Teeming Oily Blackmouth School"] = "Banc grouillant de bouches-noires huileux"
NL["Terocone"] = "Terocône"
NL["Tiger Gourami School"] = "Banc de gouramis tigres" -- Needs review
NL["Tiger Lily"] = "Lys tigré"
NL["Timber"] = "Arbre" -- Needs review
NL["Tin Vein"] = "Filon d'étain"
NL["Titanium Vein"] = "Veine de titane"
NL["Tol'vir Archaeology Find"] = "Trouvaille archéologique tol'vir"
NL["Trillium Vein"] = "Filon de trillium" -- Needs review
NL["Troll Archaeology Find"] = "Trouvaille archéologique trolle"
NL["Trove of the Thunder King"] = "Citadelle du Roi-tonnerre" -- Needs review
NL["True Iron Deposit"] = "Gisement de vérifer" -- Needs review
NL["Truesilver Deposit"] = "Gisement de vrai-argent"
NL["Twilight Jasmine"] = "Jasmin crépusculaire"
NL["Un'Goro Dirt Pile"] = "Tas de poussière d'Un'Goro"
NL["Vrykul Archaeology Find"] = "Trouvaille archéologique vrykule"
NL["Waterlogged Footlocker"] = "Cantine détrempée"
NL["Waterlogged Wreckage"] = "Débris trempés"
NL["Waterlogged Wreckage Pool"] = "Débris trempés" -- Needs review
NL["Whiptail"] = "Fouettine"
NL["White Trillium Deposit"] = "Gisement de trillium blanc" -- Needs review
NL["Wicker Chest"] = "Coffre en osier"
NL["Wild Steelbloom"] = "Aciérite sauvage"
NL["Windy Cloud"] = "Nuage venteux"
NL["Wintersbite"] = "Hivernale"

