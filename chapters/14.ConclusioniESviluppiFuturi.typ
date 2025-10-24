= Conclusioni e sviluppi futuri

Si chiude il lavoro riassumendo i contributi, i risultati emersi e le linee evolutive più promettenti. *Novità rispetto alla versione precedente:* ho reso più *operativi* gli sviluppi futuri (priorità, passi concreti, criteri di valutazione), ho ripulito la parte conclusiva per evitare ripetizioni e ho collegato i miglioramenti ai parametri effettivamente usati nella pipeline.

== Conclusioni

*Contributo metodologico.*
È stata mostrata una pipeline leggera e spiegabile per la combinazione concettuale di generi musicali, articolata in: (i) raccolta ed *enrichment* dei testi da Genius con stima della ripetizione; (ii) prototipi per brano con pesi normalizzati; (iii) profili di macro–genere con *tipiche/rigide*; (iv) preprocessing `HEAD/MODIFIER` e combinazione con *CoCoS* (scenari pesati in stile *TCL*); (v) *recommender* che classifica e spiega i suggerimenti in base ai tratti ereditati dallo scenario selezionato.

*Trasparenza.*
Ogni raccomandazione espone *rigide* rispettate, *tipiche* attivate e *scenario score*, abilitando auditabilità e controllo fine (soglie, elenco proprietà, ruolo `HEAD/MODIFIER`).

*Risultati pratici.*
La pipeline ha prodotto prototipi ibridi plausibili per molte coppie di generi, con copertura piena nei casi in cui *CoCoS* ha generato scenari e spiegazioni coerenti con i profili. Dove i profili sono ricchi, *CoCoS* propone più scenari sensati; dove sono poveri, prevalgono segnali trasversali (es. `high_repetition`), evidenziando l’importanza di *tipiche* distintive.

*Limiti.*
(i) dipendenza dalla qualità di testi/metadata; (ii) ipotesi di indipendenza nello *scenario score*; (iii) ruoli `HEAD/MODIFIER` talvolta rigidi; (iv) supporto multilingua non ancora end‑to‑end (tokenizzazione, stoplist, lemmatizzazione centrati sull’inglese).

== Sviluppi futuri

*Multilingua (priorità).*  
*Obiettivo.* Portare estrazione e prototipi a più lingue (italiano in primis).  
*Passi.* Tokenizzazione, stoplist e lemmatizzazione per lingua; normalizzazione *cross‑lingua* di proprietà/sinonimi e mapping dei tag; auto‑rilevazione della lingua del brano; fallback monolingua.  
*Valutazione.* Stabilità delle *tipiche/rigide* per lingua, tasso di scenario “valido” per coppia, coerenza delle spiegazioni.

*Feature audio e metadata strutturati.*  
*Obiettivo.* Integrare descrittori audio (tempo, energia, spettrali) e campi strutturati (anno, provenienza, *mood*) come *tipiche* o *rigide*.  
*Passi.* Estrazione automatica; fusione *early* (arricchire i profili) o *late* (pesi nel recommender) con ablation study.  
*Valutazione.* Variazione di copertura, diversità/novità nelle playlist, coerenza con le spiegazioni testuali.

*Apprendimento di pesi e vincoli.*  
*Obiettivo.* Stimare automaticamente gradi tipici e regole leggere di co‑occorrenza/antagonismo.  
*Passi.* Weak/active learning con feedback del curatore; aggiornamento incrementale dei profili.  
*Valutazione.* Riduzione delle dipendenze da segnali orizzontali (`high_repetition`), aumento del numero di scenari non banali.

*Arricchimento lessicale e mapping di genere.*  
*Obiettivo.* Ridurre la frammentazione del vocabolario e catturare sottogeneri emergenti.  
*Passi.* Liste di termini (slang, neologismi), n‑gram/MPW, rappresentazioni distribuzionali per sinonimia; mapping SUB→MACRO più fine.  
*Valutazione.* Incremento di *tipiche* non trasversali per genere, riduzione dei “no match” utili.

*CoCoS più espressivo.*  
*Obiettivo.* Migliorare la qualità degli scenari.  
*Passi.* Gruppi coerenti di feature e penalità per combinazioni incoerenti; plasticità del ruolo `HEAD/MODIFIER`; scelta automatica del verso (`H/M` o `M/H`); mantenere *top‑k* scenari e demandare al recommender un rimescolamento pesato.  
*Valutazione.* Maggiore varietà di scenari per coppia, minor sovra‑uso di segnali trasversali, aumento della qualità percepita.

*Valutazione su utenti.*  
*Obiettivo.* Misurare utilità e fiducia delle spiegazioni.  
*Passi.* Studio utente e A/B test; metriche di soddisfazione, trasparenza percepita e “comprensibilità” delle spiegazioni; confronto con *baseline* neurali/collaborative.  
*Valutazione.* Preferenza degli utenti per le playlist spiegabili a parità di qualità; tempo di comprensione delle motivazioni.

*Tooling e riproducibilità.*  
*Obiettivo.* Rendere il sistema facile da usare e da replicare.  
*Passi.* Report automatici di copertura (brani non classificati, proprietà mai attivate, *rigide* bloccanti); *packaging* con configurazioni condivisibili e `seed` fissati; script di benchmark.  
*Valutazione.* Tempo di setup ridotto, ripetibilità dei risultati, report diagnostici chiari.

== Roadmap suggerita (breve)

Q1: Multilingua (IT) + diagnostica di copertura.  
Q2: Audio/metadata + arricchimento lessicale/MPW.  
Q3: Apprendimento di pesi e regole leggere + *top‑k* scenari.  
Q4: Studio utente/A‑B test + packaging per rilascio pubblico.

== In sintesi

Il paradigma *prototipi + combinazione tipica* risulta efficace e trasparente per generare crossover musicali spiegabili. Con multilingua, feature audio e apprendimento dei pesi, il sistema può evolvere in uno strumento pratico di *curation* e *discovery* per playlist, editoria e creatività assistita, mantenendo tracciabilità delle scelte.
