= Introduzione

La raccomandazione musicale è ormai comune nelle varie piattaforme di streaming, ma molti sistemi restano opachi, ossia suggeriscono contenuti ma senza chiarirne i criteri alla base delle loro scelte. In ambito accademico e industriale vi è un crescente interesse verso soluzioni content-based e spiegabili, in grado di operare anche in assenza di segnali utente e di giustificare le scelte in modo trasparente. Questa tesi adatta e applica il framework *DEGARI* _(tipicità + combinazione di concetti)_ al dominio musicale, mostrando come prototipi e scenari possano guidare raccomandazioni interpretabili.

Questo lavoro presenta *DEGARI-Music*, un prototipo di sistema di raccomandazione che sfrutta la combinazione di concetti e la tipicità per costruire prototipi di generi (e ibridi _cross-genere_) a partire dai testi e caratteristiche stilistiche dei brani. L’approccio si fonda sul framework logico _TCL (Typicality-based Compositional Logic)_ e sul tool _CoCoS_, adattati al dominio musicale. In sintesi, proprietà _rigide_ e _tipiche_ dei generi vengono estratte dai testi (Genius) e normalizzate; la logica seleziona scenari coerenti e non banali per la combinazione _HEAD/MODIFIER_; il risultato è un prototipo concettuale impiegato per riclassificare i brani e suggerire contenuti affini, con spiegazioni _ancorate_ ai tratti ereditati e alla _forza_ (punteggio) dello scenario selezionato.

== Obiettivi

Adattare il framework *DEGARI* al dominio musicale, proponendo un sistema _content-based_ e spiegabile basato sui testi delle canzoni, che impiega la combinazione di concetti e la tipicità per costruire prototipi di genere e ibridi _cross-genere_.

Realizzare una pipeline riproducibile per l’estrazione dei testi e delle caratteristiche da *Genius*, il pre-processing linguistico e la normalizzazione dei dati lessicali necessari all’elaborazione logica.

Costruire prototipi di genere che rappresentino le proprietà *rigide* e *tipiche* di ciascun genere musicale, da utilizzare per classificazione e raccomandazione.

Fornire spiegazioni sintetiche e leggibili, basate su tratti lessicali e proprietà ereditate dai prototipi.

Validare il comportamento del sistema tramite verifiche automatiche e analisi qualitative su combinazioni di generi.

Rilasciare una pipeline modulare e integrabile con basi di conoscenza diverse.

== Contributi

*Adattamento del framework DEGARI.* Il lavoro estende l’uso del sistema originario, basato su *TCL* e *CoCoS*, dal dominio concettuale generale a quello musicale. Sono stati definiti formati di input compatibili con i testi delle canzoni e procedure di generazione dei prototipi.

*Pipeline testi → prototipi di genere.* Implementata una catena completa per la raccolta dei testi da *Genius*, la pulizia e lemmatizzazione, la selezione dei lemmi informativi e la costruzione dei prototipi di genere con proprietà *rigide* e *tipiche* pronte per l’elaborazione logica.

*Pre-processing per CoCoS.* Sviluppati gli script per la preparazione automatica delle coppie *HEAD/MODIFIER* e per la produzione dei file di input necessari alla combinazione concettuale, con gestione delle inclusioni rigide e dei conflitti di tipicità.

*Generazione dei prototipi ibridi.* Utilizzato *CoCoS* per combinare i prototipi di genere, ottenendo nuovi generi *cross-genere* caratterizzati da tratti coerenti e plausibili, successivamente riutilizzati per classificazione e raccomandazione.

*Classificatore e sistema di raccomandazione.* Implementato un modulo che impiega i prototipi generati per riclassificare i brani e produrre raccomandazioni spiegabili, basate sui tratti lessicali ereditati e sugli scenari selezionati dal framework logico.

*Riproducibilità e validazione.* Forniti script, configurazioni e documentazione per eseguire l’intera pipeline, con valutazioni automatiche e analisi qualitative su combinazioni di generi rappresentative.

== Metodologia in breve

*Estrazione e pre-processing (Genius).* Raccolta dei testi musicali tramite crawler su *Genius*; rimozione di *stopwords*, gestione delle forme flesse, filtraggio di lemmi poco informativi; lemmatizzazione e normalizzazione lessicale.

*Generazione dei prototipi di genere.* Per ciascun genere: conteggio dei lemmi caratteristici, assegnazione di punteggi di frequenza; applicazione di una soglia di significatività; *rescaling* dei punteggi nel range compatibile con il framework *TCL*.

*TCL / CoCoS – combinazione concettuale.* Annotazione delle proprietà tipiche con grado $p$; generazione di scenari coerenti per ciascuna coppia *HEAD/MODIFIER*; selezione non banale con euristica HEAD preferenziale; le inclusioni risultanti assumono la forma $p :: T(C) subset.eq.sq D$.

*Classificazione e ranking.* Un brano è considerato compatibile con un prototipo se soddisfa i vincoli *rigidi* e possiede una sufficiente parte delle proprietà tipiche attive; il punteggio per il ranking deriva dall’allineamento tra i tratti del brano e quelli del prototipo, e viene utilizzato per ordinare raccomandazioni.

== Perimetro e limiti

Il sistema illustrato opera esclusivamente in ambito *content-based* sui testi: non utilizza (al momento) feature audio o metadati strutturati (anno, artista, popolarità). Questa scelta delimita il perimetro del lavoro, impedendo l’uso di segnali complementari che potrebbero migliorare il ranking.

Le assunzioni di indipendenza tra proprietà tipiche e la scelta delle soglie e della normalizzazione, pur compatibili con il framework teorico, possono introdurre distorsioni nel calcolo del punteggio finale e influenzare l’ordine delle raccomandazioni. In particolare, valori soglia troppo bassi possono generare ambiguità (inclusione di generi “vicini” ma non pertinenti), mentre soglie troppo elevate rischiano di escludere generi validi o far fallire l’assegnazione.

Aspetti linguistici più avanzati, come polisemia ed espressioni multi-parola, sono gestiti in modo conservativo e non completamente disambiguati, il che può limitare la pertinenza delle proprietà estratte in contesti complessi.

Infine, il sistema è limitato dal punto di vista linguistico: l’estensione multilingua è prevista solo come sviluppo futuro; attualmente funziona solamente su contenuti in lingua inglese.

== Definizioni chiave (in breve)

*Tipicità.* Grado `p in [0.5, 1]` che quantifica quanto una proprietà è caratteristica (ma *sospendibile*) di un genere/concetto.

*Proprietà rigide.* Vincoli *non sospendibili* che devono essere rispettati da tutti i brani del genere.

*HEAD/MODIFIER.* Nella combinazione, l’*HEAD* è il genere principale la cui identità va preservata; il *MODIFIER* apporta tratti modificativi.

*Scenario.* Sottoinsieme coerente di *tipiche* (più le *rigide*) selezionato da *CoCoS* e valutato con uno *scenario score* (prodotto dei `p` delle tipiche attive).

== Esempio pratico

Combinando il genere *reggae* (HEAD) con il genere *rap* (MODIFIER), *CoCoS* può selezionare uno scenario che preserva `reggae` e attiva tratti trasversali come `high_repetition` o `hook_repetition`. Il *recommender* suggerisce quindi brani rap con un ritornello ridondante ad un ascoltatore reggae, *spiegando* la scelta tramite le proprietà condivise col prototipo ibrido.

== Ambito sperimentale

Per il prototipo dimostrativo sono considerati *macro-generi* comuni e un corpus di testi raccolti da *Genius*. I parametri più rilevanti della pipeline (es. `topk_typical`, `max_rigid`, `--min-match-rate`, `--min-anchors`) sono resi espliciti nei capitoli metodologici e nel capitolo riservato ai *Risultati* ottenuti.


== Sintesi

*DEGARI-Music* dimostra che tipicità e combinazione concettuale possono supportare raccomandazioni musicali robuste e interpretabili. I prototipi di genere e gli ibridi *cross-genere* forniscono tratti leggibili e riutilizzabili lungo la pipeline (riclassificazione → ranking → spiegazioni). Il sistema è progettato per future estensioni (multilingua, audio, metadati) e valutazioni su scala con utenti reali, mantenendo la trasparenza come fondamento del metodo.
