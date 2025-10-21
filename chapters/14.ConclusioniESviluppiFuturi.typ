
= Conclusioni e sviluppi futuri

Chiudiamo il lavoro riassumendo i contributi principali, i risultati emersi e le direzioni più promettenti.

== Conclusioni

*Contributo metodologico.*
Abbiamo mostrato che una pipeline leggera e spiegabile può supportare la combinazione concettuale di generi musicali, articolata in:
- raccolta ed *enrichment* dei testi da Genius con stima della ripetizione;
- prototipi per brano con pesi normalizzati;
- costruzione di profili *tipiche/rigide* per macro-genere;
- preprocessing `HEAD/MODIFIER` e combinazione con *CoCoS* (scenari pesati in stile *TCL*);
- *recommender* che classifica e spiega i suggerimenti sulla base dei tratti ereditati dallo scenario selezionato.

*Trasparenza.*
Ogni raccomandazione è accompagnata da *rigide* rispettate, *tipiche* attivate e *scenario score*. Questo abilita auditabilità e controllo fine (ad es. agendo su soglie o sul ruolo `HEAD/MODIFIER`).

*Risultati pratici.*
La pipeline ha prodotto prototipi ibridi plausibili per molte coppie di generi, con copertura piena in diversi casi e spiegazioni coerenti con i profili. Dove i profili sono ricchi, *CoCoS* propone più scenari sensati; dove sono poveri, emergono soprattutto segnali trasversali (es. `high_repetition`), evidenziando l’importanza di *tipiche* distintive.

*Limiti.*
(i) dipendenza dalla qualità di testi/metadata;  
(ii) ipotesi di indipendenza dei pesi tipici nello *scoring*;  
(iii) ruoli `HEAD/MODIFIER` talvolta troppo rigidi;  
(iv) multilingua non ancora supportata end-to-end (tokenizzazione, stoplist, lemmatizzazione focalizzate sull’inglese).

== Sviluppi futuri

*Multilingua (priorità).*  
- portare estrazione e prototipi a più lingue (italiano in primis): tokenizzazione, stoplist e lemmatizzazione per lingua;  
- normalizzazione *cross-lingua* delle proprietà (sinonimi, varianti morfologiche) e mapping dei tag;  
- scelta dinamica della lingua del brano ed eventuale combinazione multilingua.

*Feature audio e metadata strutturati.*  
- integrare descrittori audio (tempo, energia, spettrali) e campi strutturati (anno, provenienza, *mood* editoriali) come *tipiche* aggiuntive o *rigide*;  
- fusione *early/late* con pesi apprendibili dal feedback.

*Apprendimento dei pesi e dei vincoli.*  
- stimare automaticamente gradi tipici e piccole regole di co-occorrenza/antagonismo tra proprietà;  
- *active learning* per far correggere al curatore gli scenari e aggiornare i profili.

*Arricchimento lessicale e mapping di genere.*  
- ampliare le liste di termini rilevanti (inclusi slang e sottogeneri emergenti);  
- usare rappresentazioni distribuzionali per consolidare sinonimi e ridurre la frammentazione del vocabolario.

*CoCoS più espressivo.*  
- scenari con gruppi coerenti di feature (es. “se `trap`, preferisci pattern ritmici ricorrenti”) e penalità per combinazioni incoerenti;  
- plasticità del ruolo `HEAD/MODIFIER` e scelta automatica del verso più naturale (`H/M` o `M/H`) per ogni coppia.

*Valutazione su utenti.*  
- studio utente e A/B test sulle spiegazioni per misurare fiducia, utilità percepita e qualità del *discovery*;  
- metriche di diversità/novità per playlist ibride e confronto con *baseline* neurali o collaborative.

*Tooling e riproducibilità.*  
- report automatici di copertura (brani non classificati, proprietà mai attivate, *rigide* bloccanti);  
- *packaging* della pipeline con configurazioni condivisibili e *seed* fissati per esperimenti ripetibili.

*In sintesi.*
La tesi mostra che prototipi + combinazione tipica è un paradigma efficace e trasparente per generare crossover musicali spiegabili. Con multilingua, feature audio e apprendimento dei pesi, il sistema può evolvere in uno strumento pratico di *curation* e *discovery* per playlist, editoria e creatività assistita.
