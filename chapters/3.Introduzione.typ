= Introduzione

La raccomandazione musicale è ormai comune nelle varie piattaforme di streaming, ma molti sistemi restano opachi, ossia suggeriscono contenuti ma senza chiarirne i criteri alla base delle loro scelte. In ambito accademico e industriale vi è un crescente interesse verso soluzioni content-based e spiegabili, in grado di operare anche in assenza di segnali utente e di giustificare le scelte in modo trasparente. Questa tesi adatta e applica il framework *DEGARI* _(tipicità + combinazione di concetti)_ al dominio musicale, mostrando come prototipi e scenari possano guidare raccomandazioni interpretabili.

Questo lavoro presenta *DEGARI-Music*, un prototipo di sistema di raccomandazione che sfrutta la combinazione di concetti e la tipicità per costruire prototipi di generi (e ibridi _cross-genere_) a partire dai testi e caratteristiche stilistiche dei brani. L’approccio si fonda sul framework logico _TCL (Typicality-based Compositional Logic)_ e sul tool _CoCoS_, adattati al dominio musicale. In sintesi, proprietà _rigide_ e _tipiche_ dei generi vengono estratte dai testi (Genius) e normalizzate; la logica seleziona scenari coerenti e non banali per la combinazione HEAD/MODIFIER; il risultato è un prototipo concettuale impiegato per riclassificare i brani e suggerire contenuti affini, con spiegazioni _ancorate_ ai tratti ereditati e alla _forza_ (punteggio) dello scenario selezionato.

== Obiettivi

Adattare il framework *DEGARI* al dominio musicale, proponendo un sistema _content-based_ e spiegabile basato sui testi delle canzoni, che impiega la combinazione di concetti e la tipicità per costruire prototipi di genere e ibridi _cross-genere_.

Realizzare una pipeline riproducibile per l’estrazione dei testi e delle caratteristiche da *Genius*, il pre-processing linguistico e la normalizzazione dei dati lessicali necessari all’elaborazione logica.

Fornire spiegazioni sintetiche e leggibili, basate su tratti lessicali e proprietà ereditate dai prototipi.

Validare il comportamento del sistema tramite verifiche automatiche e analisi qualitative su combinazioni di generi.

Rilasciare una pipeline riproducibile, modulare e integrabile con basi di conoscenza diverse.

== Contributi

*Realizzare* una pipeline end-to-end sui testi (Genius): estrazione, pulizia, lemmatizzazione; selezione di token informativi; normalizzazione nel range richiesto dal framework.

*Prototipare* _i generi_: definizione di proprietà rigide (vincoli necessari) e tipiche (con grado $p \in (0.5,1]$), pronte per _TCL_.

*Combinare* concetti con _CoCoS_: generazione/valutazione di scenari; rispetto delle rigide; preferenza all’HEAD nei conflitti; esclusione di esiti banali.

*Implementare* _classificatore e recommender_ spiegabili: uso della mappa proprietà (cos'è cosa intendi? sappi che non posso usare termini poi non presenti) → grado e di ＠scenario (cosa intendi? cos'è?) per riclassificazione, ranking e spiegazioni.

*Validare* _il sistema_ con valutazioni automatiche e analisi qualitative su casi rappresentativi _(ibridi cross-genere)_.

== Metodologia in breve

Estrazione e pre-processing (Genius). Raccolta descrizioni/testi; rimozione stopwords, gestione forme flesse, filtraggio elementi non informativi; lemmatizzazione.

Prototipi di genere. Conteggio e ponderazione dei lemmi caratteristici per genere; soglia di significatività; rescaling nel range compatibile con TCL.

TCL/CoCoS. Proprietà tipiche annotate con $p$; generazione di scenari coerenti; selezione non banale con euristica HEAD/MODIFIER; inclusioni nella forma $p :: T(C) subset.eq.sq D$.

Classificazione & ranking. Un brano è compatibile con un concetto se soddisfa i vincoli rigidi e una quota sufficiente di proprietà tipiche; il punteggio deriva dall’allineamento dei tratti (riutilizzato nelle spiegazioni).

== Perimetro e limiti

Il sistema è content-based sui testi: non usa (ancora) feature audio o metadati strutturati (anno, artista, popolarità).
Le assunzioni di indipendenza tra proprietà tipiche e la scelta di soglie/normalizzazione, pur standard nel framework, possono influire sul ranking.
Aspetti linguistici avanzati (polisemia, espressioni multi-parola) sono gestiti in modo conservativo. L’estensione multilingua è prevista tra gli sviluppi futuri.

== Struttura della tesi

Cap. 4 – Fondamenti teorici: logiche descrittive, tipicità e chiusura razionale; TCL e l’euristica HEAD/MODIFIER.
Cap. 5 – TCL e strumenti: razionale e scelte implementative per l’integrazione con CoCoS.
Cap. 6 – Estrazione dei dati (Genius): raccolta e pre-processing dei testi; pipeline linguistica.
Cap. 7 – Creazione dei prototipi: dalle frequenze ai gradi di tipicità; tratti rigidi e tipici.
Cap. 8 – BuildTypicalRigid: materializzazione dei prototipi in input per CoCoS/TCL.
Cap. 9 – Preprocessing CoCoS: preparazione delle coppie HEAD/MODIFIER e generazione degli scenari.
Cap. 10 – CoCoS: selezione degli scenari plausibili; costruzione dei prototipi ibridi cross-genere.
Cap. 11 – Sistema di raccomandazione: classificatore, ranking e spiegazioni (ancore e scenario).
Cap. 12 – Risultati: evidenze quantitative e qualitative su riclassificazione e raccomandazioni.
Cap. 13 – Discussione: punti di forza/limiti, sensibilità a soglie e scelte semantiche.
Cap. 14 – Conclusioni e sviluppi futuri: multilingua, integrazione di feature audio/metadata, lessici d’intensità e aspetti temporali, studio utente sulle spiegazioni.

== Sintesi

DEGARI-Music mostra come tipicità e combinazione di concetti possano sostenere raccomandazioni musicali robuste e spiegabili. I prototipi di genere e degli ibridi cross-genere forniscono tratti interpretabili e riutilizzabili lungo l’intera pipeline (riclassificazione → ranking → spiegazioni). Il sistema apre a estensioni naturali (multilingue, audio, metadati) e a valutazioni su scala con utenti, mantenendo la trasparenza come requisito di progetto.