= Discussione

Questo capitolo interpreta i risultati alla luce della pipeline (prototipi → *CoCoS* → recommender), evidenziando limiti, confronto con alternative e implicazioni d’uso. Funziona da ponte logico tra *Risultati* e *Conclusioni*.

== Dove il sistema fallisce (e perché)

*Propagazione degli errori.* Ogni modulo eredita i vincoli del precedente: profili *tipiche/rigide* scarsi o sbilanciati generano pochi scenari e bassa copertura del recommender.

*Dominanza di segnali trasversali.* Tratti “orizzontali” (es. `high_repetition`) allargano la platea ma riducono la specificità se mancano *tipiche* distintive. *Rimedi:* (i) aumentare `MAX_ATTRS` solo quando esistono *tipiche* non trasversali, (ii) rinforzare *tipiche* caratterizzanti dell’*HEAD*, (iii) alzare moderatamente `--min-match-rate` e `--min-anchors` nel recommender.

*Assunzione di indipendenza.* Lo *scenario score* usa il prodotto dei `p` delle *tipiche* attive; proprietà fortemente correlate possono risultare sovrastimate. *Mitigazione:* semplici regole di co‑occorrenza/alternanza tra gruppi di feature.

*Euristica `HEAD/MODIFIER`.* La priorità semantica all’*HEAD* è utile ma rigida: coppie come `pop–rnb` possono richiedere simmetria o *switch* dinamico dei ruoli. *Estensioni:* parametro di “plasticità” dell’asimmetria oppure scelta `H/M` guidata dallo score di scenario.

*Rumore testuale.* Tokenizzazione/stopword inglesi e qualità variabile dei testi introducono sinonimia superficiale (senza lemmatizzazione), lessico di dominio fuori lista e residui di markup. *Rimedi:* ampliare liste/lessici, pulizia markup, lemmatizzazione quando disponibile.

== Confronto con approcci affini

*Bag‑of‑words / tf–idf.* Buone similitudini ma nessuna distinzione tra *tipiche* (difettibili) e *rigide*; manca il ruolo `HEAD/MODIFIER` e la sospendibilità dei tratti.

*Collaborative filtering / embedding neurali.* Ottime previsioni di preferenza, spiegabilità ridotta; la combinazione concettuale richiede workaround. Qui il prototipo ibrido è esplicito e auditabile (scenari + pesi).

*TCL/CoCoS.* Rispetto a logiche crisp/fuzzy tradizionali offre (i) priorità e sospendibilità delle *tipiche*, (ii) selezione di scenari con punteggi, (iii) ruolo `HEAD/MODIFIER`. Controparte: maggiore sensibilità alla qualità dei profili e all’ipotesi d’indipendenza.

== Implicazioni pratiche

*Trasparenza e controllo.* Ogni suggerimento espone *ancore* e *matches* del prototipo; il curatore può regolare soglie e liste proprietà con impatto prevedibile.

*Discovery di crossover.* Segnali trasversali (hook/ritornelli) fanno emergere brani “lontani” ma plausibili: utile per playlist tematiche, format editoriali e ideazione creativa.

*Cura dei profili.* Poche *rigide* forti e 2–3 *tipiche* distintive per genere migliorano gli scenari senza complicare la pipeline.

== Minacce alla validità

*Copertura dati.* Pochi esempi per genere riducono la stabilità di *tipiche/rigide* e lo score scenari.
*Bias di sorgente.* Testi/metadata di Genius riflettono pratiche editoriali specifiche.
*Iperparametri.* `MAX_ATTRS`, `--min-match-rate`, `--min-anchors` influenzano direttamente scenari e copertura.

== Cosa migliorare subito

*Specificità.* Arricchire i profili con *tipiche* non trasversali per genere (riduce la dipendenza da `high_repetition`).  
*Coerenza leggera.* Poche regole di preferenza/evitamento tra proprietà correlate/incompatibili.  
*Selezione scenari più soft.* Conservare i *top‑k* scenari e demandare diversificazione al recommender con pesi.  
*Diagnostica.* Report automatico: brani non classificati per coppia, proprietà mai attivate, *rigide* che annullano scenari.  
*Arricchimento linguistico.* Liste termini e mappature verso macro‑tratti; lemmatizzazione quando possibile.

== Takeaway

Il paradigma *prototipi + combinazione* offre spiegazioni locali e controllo globale con pochi iperparametri. La qualità di *tipiche/rigide* è la leva principale: profili ricchi → scenari sensati e raccomandazioni coerenti; profili poveri → prevalgono segnali trasversali. Il sistema è adatto a *discovery* e *curation* di crossover e può integrare modelli neurali/CF come *re‑ranker*, mantenendo tracciabilità delle scelte.
