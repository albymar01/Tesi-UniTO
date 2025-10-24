
= Discussione

In questo capitolo inquadriamo i risultati alla luce della pipeline (prototipi → *CoCoS* → recommender), evidenziando *criticità*, *punti di forza*, *confronto con approcci affini* e *implicazioni pratiche*. Dove utile, colleghiamo i fenomeni osservati ai *parametri effettivamente usati nel run* (es. `topk_typical`, `max_rigid`, `--min-match-rate`, `--min-anchors`).

== Dove il sistema fallisce (e perché)

*Propagazione degli errori.* Ogni modulo eredita i vincoli del precedente: profili *tipiche/rigide* poveri o sbilanciati → *CoCoS* produce pochi scenari o *nessuno*; a valle il recommender mostra copertura ridotta o suggerimenti troppo generici.

*Dominanza di segnali trasversali.* Proprietà “orizzontali” (es. `high_repetition`) aumentano la copertura, ma se mancano *tipiche* distintive spingono l’ibrido verso una semantica poco selettiva. *Rimedi pratici:* (i) includere 2–3 *tipiche* non trasversali per genere; (ii) usare `MAX_ATTRS` > 1 *solo* quando esistono *tipiche* informative da ereditare; (iii) alzare moderatamente le soglie del recommender (`--min-match-rate`, `--min-anchors`).

*Assunzione di indipendenza.* Lo *scenario score* moltiplica i `p` delle tipiche attive. Se due proprietà sono correlate (es. `trap` ↔ pattern ritmici ricorrenti), lo score può sovrastimare scenari “ridondanti”. *Correzioni leggere:* piccole regole di co-occorrenza/alternanza (es. “se `A` allora riduci il peso di `B`”), o gruppi di feature con controllo congiunto.

*Euristica `HEAD/MODIFIER`.* La priorità all’*HEAD* aiuta a preservare l’identità, ma può essere *rigida*. Alcune coppie (es. `pop–rnb`) richiedono simmetria o *switch* dinamico del verso. *Estensioni possibili:* parametro di “plasticità” dell’asimmetria; scelta automatica H/M guidata dai punteggi di scenario.

*Rumore testuale.* Tokenizzazione/stopword EN e qualità variabile dei testi Genius introducono: (i) sinonimia superficiale (se manca la lemmatizzazione), (ii) lessico di dominio non catturato fuori whitelist, (iii) markup residuo. *Mitigazioni:* ampliare liste di termini/mapping, pulizia markup più aggressiva, usare lemmatizzatori stabili quando disponibili.

== Confronto con approcci affini

*Bag-of-words / tf–idf.* Buone similitudini, ma nessuna distinzione tra *tipiche* difettibili e *rigide*; manca `HEAD/MODIFIER` e la sospendibilità delle proprietà.

*Collaborative filtering / embedding neurali.* Predicono bene preferenze/vicinanze, ma spiegabilità più bassa; la combinazione concettuale richiede workaround (intersezioni di vicini, blending euristico). Qui il *prototipo ibrido* è esplicito e auditabile (scenari + pesi).

*TCL/CoCoS.* Rispetto a regole logiche o fuzzy tradizionali, aggiunge: (i) priorità e sospendibilità delle *tipiche*; (ii) selezione per scenari con punteggi; (iii) ruolo `HEAD/MODIFIER`. Contro: sensibilità alla qualità dei profili e all’ipotesi d’indipendenza.

== Implicazioni pratiche

*Trasparenza e controllo.* Ogni suggerimento eredita *ancore* e *matches* del prototipo: il curatore vede quali tratti governano la scelta e può regolare soglie o l’elenco proprietà per pilotare il sistema.

*Discovery di crossover.* Segnali trasversali (es. hook/ritornelli) fanno emergere brani “lontani” ma plausibili rispetto al concetto ibrido: utile per playlist tematiche, format editoriali e ideazione creativa.

*Cura dei profili.* Mantenere *poche rigide* ma forti e *tipiche* bilanciate (5–8) per genere migliora qualità degli scenari senza irrigidire la pipeline.

== Minacce alla validità

*Copertura dati limitata.* Pochi esempi per genere riducono la stabilità delle *tipiche/rigide*; dataset piccolo rende più facile la copertura “piena” ma meno generalizzabile.

*Bias di sorgente.* Testi/metadata Genius riflettono cataloghi e pratiche editoriali specifiche (lingua, mainstream).

*Scelte di iperparametri.* `MAX_ATTRS` e le soglie del recommender influenzano direttamente presenza/assenza di scenari e copertura. *Nota:* nel run finale parametri più permissivi (es. `topk_typical` ampio, `max_rigid` più alto) aumentano copertura ma anche la dipendenza da segnali orizzontali.

== Cosa migliorare subito

*Rinforzare la specificità.* Arricchire i profili con 2–3 *tipiche* non trasversali per genere (riduce la dipendenza da `high_repetition`).

*Regole di coerenza leggere.* Aggiungere preferenze/evitamenti tra proprietà chiaramente correlate o incompatibili (anti-ridondanza).

*Selezione scenari più “soft”.* Oltre al migliore, mantenere i *top-k* scenari e lasciare al recommender un rimescolamento pesato (diversifica le playlist, migliora la copertura di casi borderline).

*Diagnostica di copertura.* Report automatici: brani non classificati per coppia, proprietà mai attivate, *rigide* bloccanti, frequenza di *NO scenario* per coppia.

*Arricchimento linguistico.* Ampliare liste di termini e mapping verso macro-tratti; abilitare lemmatizzazione; considerare n-gram/MPW (multi-parola) salienti.

== Takeaway

Il paradigma *prototipi + combinazione* fornisce spiegazioni locali e controllo globale con pochi iperparametri. La qualità dei profili *tipiche/rigide* è la leva principale: quando sono ricchi, gli scenari sono sensati e le raccomandazioni coerenti; quando sono poveri, prevalgono i segnali trasversali. Il sistema è adatto a *discovery* e *curation* di crossover, e può integrarsi con modelli neurali/CF come *re-ranker*, mantenendo però tracciabilità delle scelte.
