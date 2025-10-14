= Introduzione

La raccomandazione musicale è ormai pervasiva, ma molti sistemi restano black-box: suggeriscono contenuti efficaci, senza però chiarire perché. In ambito accademico e industriale cresce quindi l’interesse verso soluzioni content-based e spiegabili, in grado di operare anche quando mancano segnali utente e di giustificare le scelte in modo trasparente.

Questo lavoro presenta DEGARI-Music, un sistema di raccomandazione musicale che sfrutta la combinazione di concetti e la tipicità per costruire prototipi di generi (e ibridi cross-genere) a partire dai testi dei brani. L’approccio si fonda sul framework logico TCL (Typicality-based Compositional Logic) e sugli strumenti CoCoS, adattati al dominio musicale. In sintesi, proprietà rigide e tipiche dei generi vengono estratte dai testi (Genius) e normalizzate; la logica seleziona scenari coerenti e non banali per la combinazione HEAD/MODIFIER; il risultato è un prototipo concettuale utilizzato sia per riclassificare i brani, sia per raccomandare contenuti affini, con spiegazioni legate alle proprietà condivise e alla “forza” dello scenario selezionato.

== Obiettivi

Proporre un content-based, explainable recommender centrato sui testi e sulla combinazione di concetti.

Costruire prototipi di genere/ibridi come mappe proprietà → grado e impiegarli per classificazione e ranking.

Fornire spiegazioni sintetiche e leggibili (ancore lessicali, proprietà ereditate, scenario/logica di scelta).

Rilasciare una pipeline riproducibile, organizzata in moduli, integrabile con basi di conoscenza diverse.

== Contributi

Pipeline end-to-end sui testi (Genius). Estrazione, pulizia e lemmatizzazione; selezione di token informativi; normalizzazione delle frequenze nel range di probabilità atteso dal framework.

Prototipazione di genere. Costruzione di proprietà rigide (vincoli necessari) e tipiche (con grado $p \in (0.5,1]$), pronte per TCL.

Combinazione concettuale con CoCoS. Generazione e valutazione di scenari; rispetto delle rigide; preferenza all’HEAD nei conflitti; esclusione di esiti banali.

Classificatore e Recommender spiegabili. Uso della mappa proprietà → grado e degli CHIOCCIOLAscenario per: (i) attribuzione/riclassificazione; (ii) ranking; (iii) spiegazioni “per tratti” (ancore) e “per scenario” (perché quella combinazione è plausibile).

Validazione. Valutazioni automatiche e analisi qualitative su casi rappresentativi (ibridi cross-genere), con esempi di spiegazione orientati all’utente finale.

== Metodologia in breve

Estrazione e pre-processing (Genius). Raccolta descrizioni/testi; rimozione stopwords, gestione forme flesse, filtraggio elementi non informativi; lemmatizzazione.

Prototipi di genere. Conteggio e ponderazione dei lemmi caratteristici per ogni genere; soglia di significatività; rescaling nel range compatibile con TCL.

TCL/CoCoS. Proprietà tipiche annotate con $p$; generazione di scenari coerenti; selezione non banale con euristica HEAD/MODIFIER; inclusioni nella forma $p :: T(C) subset.eq.sq D$.

Classificazione & ranking. Un brano è compatibile con un concetto se soddisfa i vincoli rigidi e una quota sufficiente di proprietà tipiche; il punteggio deriva dall’allineamento dei tratti (riutilizzato nelle spiegazioni).

== Perimetro e limiti

Il sistema è content-based sui testi: non usa (ancora) feature audio o metadati strutturati (anno, artista, popolarità).

Le assunzioni di indipendenza tra proprietà tipiche e la scelta soglia/normalizzazione, pur standard nel framework, possono influire sui ranking.

Aspetti linguistici avanzati (polisemia, multi-word expressions) sono gestiti in modo conservativo. L’estensione multilingua è prevista tra gli sviluppi futuri.

== Struttura della tesi

Cap. 4 – Fondamenti teorici. Logiche descrittive, tipicità e chiusura razionale; il framework TCL e l’euristica HEAD/MODIFIER.

Cap. 5 – TCL e strumenti. Razionale e scelte implementative per l’integrazione con CoCoS.

Cap. 6 – Estrazione dei dati (Genius). Raccolta e pre-processing dei testi; pipeline linguistica.

Cap. 7 – Creazione dei prototipi. Dalle frequenze ai gradi di tipicità; definizione di tratti rigidi e tipici.

Cap. 8 – BuildTypicalRigid. Materializzazione dei prototipi in input compatibili con CoCoS/TCL.

Cap. 9 – Preprocessing CoCoS. Preparazione delle coppie HEAD/MODIFIER e generazione degli scenari.

Cap. 10 – CoCoS. Selezione degli scenari plausibili; costruzione dei prototipi ibridi cross-genere.

Cap. 11 – Sistema di raccomandazione. Classificatore, ranking e spiegazioni (ancore e scenario).

Cap. 12 – Risultati. Evidenze quantitative e qualitative su riclassificazione e raccomandazioni.

Cap. 13 – Discussione. Punti di forza/limiti, sensibilità a soglie e scelte semantiche.

Cap. 14 – Conclusioni e sviluppi futuri. Estensione multilingua, integrazione di feature audio/metadata, lessici d’intensità e aspetti temporali, studio utente su spiegazioni.

== Sintesi

DEGARI-Music mostra come tipicità e combinazione di concetti possano sostenere raccomandazioni musicali robuste e spiegabili. I prototipi di genere e degli ibridi cross-genere forniscono tratti interpretabili e riutilizzabili lungo l’intera pipeline: dalla riclassificazione, al ranking, fino alla spiegazione al livello lessicale e logico-scenario. Il sistema apre a estensioni naturali (multilingue, audio, metadati) e a valutazioni su scala con utenti, mantenendo la trasparenza come requisito di progetto.