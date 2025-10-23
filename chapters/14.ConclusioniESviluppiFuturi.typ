= Conclusioni e sviluppi futuri

Si chiude il lavoro riassumendo i contributi, i risultati emersi e le linee evolutive più promettenti.

== Conclusioni

*Contributo metodologico.*
È stata mostrata una pipeline leggera e spiegabile per la combinazione concettuale di generi musicali, articolata in: (i) raccolta ed *enrichment* dei testi da Genius con stima della ripetizione; (ii) prototipi per brano con pesi normalizzati; (iii) profili di macro–genere con *tipiche/rigide*; (iv) preprocessing `HEAD/MODIFIER` e combinazione con *CoCoS* (scenari pesati in stile *TCL*); (v) *recommender* che classifica e spiega i suggerimenti in base ai tratti ereditati dallo scenario selezionato.

*Trasparenza.*
Ogni raccomandazione espone *rigide* rispettate, *tipiche* attivate e *scenario score*, abilitando auditabilità e controllo fine (soglie, elenco proprietà, ruolo `HEAD/MODIFIER`).

*Risultati pratici.*
La pipeline ha prodotto prototipi ibridi plausibili per molte coppie di generi, con copertura piena in vari casi e spiegazioni coerenti con i profili. Dove i profili sono ricchi, *CoCoS* propone più scenari sensati; dove sono poveri, prevalgono segnali trasversali (es. `high_repetition`), evidenziando l’importanza di *tipiche* distintive.

*Limiti.*
(i) dipendenza dalla qualità di testi/metadata; (ii) ipotesi di indipendenza nello *scenario score*; (iii) ruoli `HEAD/MODIFIER` talvolta rigidi; (iv) supporto multilingua non ancora end‑to‑end (tokenizzazione, stoplist, lemmatizzazione centrati sull’inglese).

== Sviluppi futuri

*Multilingua (priorità).*
Portare estrazione e prototipi a più lingue (italiano in primis): tokenizzazione, stoplist e lemmatizzazione per lingua; normalizzazione *cross‑lingua* di proprietà/sinonimi e mapping dei tag; scelta dinamica della lingua del brano ed eventuale combinazione multilingua.

*Feature audio e metadata strutturati.*
Integrare descrittori audio (tempo, energia, spettrali) e campi strutturati (anno, provenienza, *mood*) come *tipiche* o *rigide*; fusione *early/late* con pesi apprendibili dal feedback.

*Apprendimento di pesi e vincoli.*
Stimare automaticamente gradi tipici e regole leggere di co‑occorrenza/antagonismo; *active learning* per correggere scenari e aggiornare i profili con il curatore.

*Arricchimento lessicale e mapping di genere.*
Ampliare liste di termini (slang, sottogeneri emergenti) e usare rappresentazioni distribuzionali per consolidare sinonimi e ridurre la frammentazione del vocabolario.

*CoCoS più espressivo.*
Scenari con gruppi coerenti di feature e penalità per combinazioni incoerenti; plasticità del ruolo `HEAD/MODIFIER` e scelta automatica del verso (`H/M` o `M/H`) per ogni coppia.

*Valutazione su utenti.*
Studio utente e A/B test sulle spiegazioni per misurare fiducia/utile percepita; metriche di diversità/novità per playlist ibride e confronto con *baseline* neurali o collaborative.

*Tooling e riproducibilità.*
Report automatici di copertura (brani non classificati, proprietà mai attivate, *rigide* bloccanti); *packaging* con configurazioni condivisibili e *seed* fissati per esperimenti ripetibili.

== In sintesi

Il paradigma *prototipi + combinazione tipica* risulta efficace e trasparente per generare crossover musicali spiegabili. Con multilingua, feature audio e apprendimento dei pesi, il sistema può evolvere in uno strumento pratico di *curation* e *discovery* per playlist, editoria e creatività assistita, mantenendo tracciabilità delle scelte.
