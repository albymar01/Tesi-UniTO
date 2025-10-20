= Discussione

In questo capitolo inquadriamo i risultati alla luce della pipeline (prototipi → CoCoS → recommender), discutendo criticità, confronto con approcci affini e implicazioni d’uso.

== Dove il sistema fallisce (e perché)

Propagazione degli errori. Ogni modulo eredita i vincoli del precedente: se i profili tipiche/rigide per genere sono scarsi o sbilanciati, CoCoS produce pochi scenari o nessuno; il recommender, a valle, mostra copertura ridotta o suggerimenti troppo generici.

Dominanza di segnali trasversali. Proprietà orizzontali (es. "high_repetition") migliorano la copertura ma, se gli altri tratti sono deboli, allargano troppo la platea e riducono la specificità di genere. Rimedi pratici:

aumentare MAX_ATTRS solo quando esistono tratti non trasversali utili;

rafforzare nei profili alcune tipiche distintive dell’HEAD;

alzare moderatamente le soglie del recommender ("--min-match-rate", "--min-anchors").

Assunzione di indipendenza. Lo score di scenario tratta i pesi tipici come indipendenti. Se due proprietà sono fortemente correlate (es. trap e la presenza di pattern ritmici ricorrenti), lo scenario può sovrastimarle. Possibili correzioni: piccole regole di co-occorrenza/alternanza tra proprietà o gruppi di feature con controllo congiunto.

Euristica HEAD/MODIFIER. La priorità semantica all’HEAD è utile ma rigida: alcune coppie (es. pop–rnb) possono richiedere simmetria o uno switch dinamico dei ruoli. Estensioni possibili: parametro di “plasticità” o scelta H/M guidata dai punteggi di scenario.

Rumore testuale. Tokenizzazione/stopword inglesi e qualità eterogenea dei testi di Genius introducono:

sinonimia superficiale (se manca la lemmatizzazione);

lessico di dominio non intercettato quando fuori dalle liste utili;

occasionali etichette/markup residui.
Mitigazioni: ampliare le liste di termini rilevanti, migliorare la pulizia del markup e usare, quando disponibile, lemmatizzatori stabili.

== Confronto con approcci affini

Bag-of-words / tf–idf. Offrono buone similitudini, ma non distinguono tra tipicità difettibili e vincoli rigidi; non c’è ruolo HEAD/MODIFIER e la sospendibilità delle proprietà non è modellata.

Collaborative filtering / embedding neurali. Predicono bene preferenze e vicinanze, ma la spiegabilità è più bassa e la combinazione concettuale richiede workaround (intersezioni di vicini, ecc.). Qui il prototipo ibrido è esplicito e auditabile (scenari + pesi).

TCL/CoCoS. Rispetto a regole logiche o fuzzy tradizionali, aggiunge: (i) priorità e sospendibilità delle tipiche, (ii) selezione per scenari con punteggi, (iii) ruolo HEAD/MODIFIER. Il rovescio della medaglia è una maggiore sensibilità alla qualità dei profili e all’ipotesi d’indipendenza.

== Implicazioni pratiche

Trasparenza e controllo. Ogni suggerimento eredita ancore e matches del prototipo: il curatore può vedere quali tratti governano le scelte e regolare soglie/elenco proprietà per pilotare le proposte.

Discovery di crossover. Segnali trasversali (hook/ritornelli) fanno emergere brani “lontani” ma plausibili rispetto al concetto ibrido: utile per playlist tematiche, format editoriali e ideazione creativa.

Cura dei profili. Aggiungere poche tipiche distintive per genere e mantenere rigide poche ma forti migliora la qualità degli scenari senza complicare la pipeline.

== Minacce alla validità

Copertura dati limitata. Pochi esempi per genere riducono la stabilità delle tipiche/rigide.
Bias di sorgente. Testi/metadata di Genius riflettono cataloghi e pratiche editoriali specifiche.
Scelte di iperparametri. MAX_ATTRS e le soglie del recommender influiscono direttamente sulla presenza/assenza di scenari e sulla copertura.

== Cosa migliorare subito

Rinforzare la specificità. Arricchire i profili con 2–3 tipiche non trasversali per genere (riduce la dipendenza da "high_repetition").
Regole di coerenza leggere. Aggiungere poche regole di preferenza/evitamento tra proprietà chiaramente correlate o incompatibili.
Selezione scenari più soft. Oltre al migliore, mantenere i top-k scenari e lasciare al recommender un rimescolamento pesato per diversificare le playlist.
Diagnostica di copertura. Report automatico: brani non classificati per coppia, proprietà mai attivate, rigide che annullano gli scenari.
Arricchimento linguistico. Ampliare liste di termini e mappature verso macro-tratti; abilitare lemmatizzazione quando possibile.

== Takeaway

Il paradigma prototipi + combinazione fornisce spiegazioni locali e controllo globale con pochi iperparametri.
La qualità dei profili tipiche/rigide è la leva principale: quando sono ricchi, gli scenari sono sensati e le raccomandazioni coerenti; quando sono poveri, prevalgono i segnali trasversali.
Il sistema è adatto a discovery e curation di crossover, e può integrarsi con modelli neurali/CF come re-ranker, mantenendo però tracciabilità delle scelte.