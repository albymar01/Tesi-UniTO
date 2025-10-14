= Discussione

Inquadriamo i risultati alla luce della pipeline (prototipi → CoCoS → raccomandatore), discutendo criticità, confronto con approcci affini e implicazioni d’uso.

== Dove il sistema fallisce (e perché)

Propagazione degli errori. Ogni modulo erede i vincoli del precedente: se i profili typical/rigid sono scarsi o sbilanciati, CoCoS genera pochi scenari o nessuno; il raccomandatore, a cascata, ha copertura ridotta o suggerimenti troppo generici.

Dominanza di segnali trasversali. Tag orizzontali (es. high_repetition) migliorano la copertura ma, se gli altri tratti sono deboli, allargano troppo la platea e “schiacciano” la specificità di genere. Rimedi pratici:

aumentare topk_typical solo se esistono tratti non-trasversali;

alzare la penalità dei “globaloni” (COMMON_PENALTY) o innalzare le soglie typical_thr;

usare MAX_ATTRS ≥ 2 ma con almeno una tipica fortemente distintiva dell’HEAD.

Assunzioni di indipendenza. Lo score degli scenari moltiplica pesi tipici come se fossero indipendenti. Quando due proprietà sono correlate (es. trap e 808), lo scenario può sovrastimarle. Possibili fix: regole di mutua esclusione/coesione o “gruppi” di feature con peso congiunto.

Heuristics Head/Modifier. La priorità semantica all’HEAD è utile ma rigida: alcuni mix (es. pop↔rnb) potrebbero richiedere simmetria o switch dinamico del ruolo. Si può introdurre un parametro di “plasticità” o una scelta H/M guidata dai punteggi.

Rumore testuale. Tokenizzazione/stopword inglesi e qualità variabile dei testi di Genius introducono:

sinonimia superficiale (manca normalizzazione a lemmi se TreeTagger non è disponibile);

lessico di dominio non catturato se fuori whitelist;

mappe SUB2MACRO incomplete su tag rari.
Mitigazioni: ampliare DOMAIN_WHITELIST, raffinando SUB2MACRO e (se disponibile) usare lemmatizzatori robusti.

== Confronto con approcci affini

Baselines “bag-of-words” o tf–idf. Offrono buone similitudini ma non distinguono tra tipicità (difettibile) e vincoli rigidi; mancano ruoli HEAD/MODIFIER e non motivano perché certe proprietà “saltano” o vengono sospese.

Collaborative filtering / embedding neurali. Predicono bene preferenze e vicinanze, ma la spiegabilità è bassa e la combinazione concettuale richiede hack (intersezione di vicini). Qui, invece, il prototipo ibrido è esplicito e auditabile, con scenari e pesi tracciabili.

TCL/CoCoS. Rispetto a semplici regole logiche o fuzzy, aggiunge: (i) priorità gerarchica e sospendibilità delle tipiche, (ii) selezione per scenari con punteggi, (iii) ruolo H/M. Il trade-off è una maggiore sensibilità alla qualità dei profili e all’ipotesi d’indipendenza dei pesi.

== Implicazioni pratiche

Trasparenza e controllo. Ogni suggerimento eredita ancore e matches del prototipo: l’utente (o il curatore) può vedere quali tratti hanno governato il ranking e regolare soglie/whitelist per pilotare le proposte.

Discovery di crossover. La presenza di segnali trasversali (hook, ripetizione) fa emergere brani di generi “lontani” ma plausibili rispetto al concept ibrido. È utile per playlist tematiche, format radio e ideazione creativa (moodboard sonori).

Cura dei profili. Il sistema incentiva la manutenzione leggera dei dizionari: aggiungere 2–3 tipiche distintive per genere migliora molto gli scenari; la rigidità va usata con parsimonia (ancore poche ma forti).

== Minacce alla validità

Copertura dati. Il campione è limitato; pochi esempi per un genere riducono la stabilità dei typical/rigid.

Bias di sorgente. Testi/metadata di Genius riflettono cataloghi e pratiche editoriali specifiche.

Scelte di iperparametri. MIN_W/MAX_W, soglie e MAX_ATTRS influenzano direttamente gli scenari; risultati diversi con settaggi diversi.

== Cosa migliorare subito

Rinforzare la specificità. Aumentare DISTINCTIVE_BOOST o arricchire i profili con 2–3 tratti non-trasversali per genere (riduce l’effetto calamita di high_repetition).

Regole di coerenza. Piccolo set di vincoli: se trap allora preferisci 808; se reggae evita double_kick.

Selezione scenari soft. Oltre al best, tenere top-k scenari e far decidere al raccomandatore con un rimescolamento pesato (diversifica le playlist).

Diagnostica di copertura. Report automatico: brani non classificati per coppia, proprietà mai attivate, rigid che azzerano gli scenari.

Arricchimento linguistico. Estendere whitelist e mappature SUB2MACRO; dove possibile, lemmatizzazione stabile per ridurre la frammentazione del lessico.

== Takeaway

Il paradigma prototipi + combinazione fornisce spiegazioni locali e controllabilità globale con pochissimi iperparametri.

La qualità dei profili typical/rigid è la leva principale: quando sono ricchi, gli scenari sono sensati e le raccomandazioni coerenti; quando sono poveri, prevale il segnale trasversale.

Il sistema è adatto a discovery e curation di crossover, lasciando spazio a moduli neurali/CF come re-ranker, mantenendo però tracciabilità delle scelte.