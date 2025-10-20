= Combinazione di generi musicali con CoCoS (Modulo 2)
In questo capitolo si descrive come, a partire dalle proprietà *rigide* e *tipiche* per macro-genere, *CoCoS* costruisce scenari di combinazione *HEAD/MODIFIER* e seleziona i prototipi dei concetti ibridi (es. pop–rap).

== Input, preprocessing e formato dei file

*Input.* Le directory `typical/` e `rigid/` prodotte dal modulo di costruzione dei profili (cap. 8: *BuildTypicalRigid*), più la cartella dei file `.txt` per ciascuna coppia `H_M` in `prototipi_music/` (creata da `cocos_preprocessing.py`).

Ogni file `H_M.txt` contiene:
- intestazione con *Head Concept Name* e *Modifier Concept Name*;
- elenco delle *rigide* di *head* e *modifier*;
- inclusioni *tipiche* annotate come $p :: T(C) subset.eq.sq D$ con $p in (0.5, 1]$.


*Esempio sintetico (pop–rap).*
Head Concept Name: pop
Modifier Concept Name: rap

head, pop
head, high_repetition

modifier, high_repetition

T(head), pop, 0.95
T(head), high_repetition, 0.629
T(head), hook_repetition, 0.629
T(head), catchy_chorus, 0.6

T(modifier), high_repetition, 0.8


== Vincoli e ruolo HEAD/MODIFIER

- Le *rigide* di entrambi i concetti devono sempre essere rispettate.
- Tra le *tipiche*, *CoCoS* privilegia scenari coerenti con la fisionomia dell’*HEAD*; il *MODIFIER* introduce aggiustamenti compatibili (cfr. TCL nei capp. 2–3).
- Un limite al numero di tipiche selezionabili (`MAX_ATTRS` in `cocos_config.py`, default 2) evita combinazioni “sovraccariche”.


== Generazione e valutazione degli scenari
Dalle tipicità disponibili si costruiscono sottoinsiemi ammissibili (rispetto a rigide e al limite `MAX_ATTRS`).  
A ciascuno scenario si associa uno *score* in stile *DISPONTE* (indipendenza dei pesi tipici): lo *score* è il *prodotto* dei gradi $p_i$ delle tipicità attive (oppure un’eventuale trasformazione monotona equivalente implementata nel codice per stabilità numerica).  
Gli scenari sono ordinati per *score*; in caso di parità si mantengono più *best*.

== Selezione e output

Per ciascun file `H_M.txt`, *CoCoS*:
- stampa a console gli scenari consigliati;
- appende al file due righe riassuntive:


Result: {"pop": 0.95, "high_repetition": 0.80, "hook_repetition": 0.629, "＠scenario_score": ...}
Scenario: [1, 1, 0, 1, 0, ...]


(Opzionale) Con l’opzione `-o` salva un JSON pulito in `prototipi_music/scenarios_json/` con tutti gli *best*.
Esempio di risultato (*pop–rap*):

`Result: {"pop": 0.95, "high_repetition": 0.8, "hook_repetition": 0.629, "@scenario_probability": 7.0941136, "@scenario_score": 7.0941136}`  
`Scenario: [1, 1, 0, 1, 0, 7.0941136]`



== Parametri rilevanti

- `MAX_ATTRS` (default 2): massimo numero di tipiche ereditabili.  
- *CLI (`cocos.py`):*
  - esecuzione su tutta la cartella configurata:  
    `python cocos.py`
  - esecuzione su una coppia specifica:  
    `python cocos.py path\H_M.txt 3 -o path\scenarios_json`

== Casi senza scenario

Se nessuno scenario supera i vincoli (rigide, coerenza *HEAD/MODIFIER*, limite attributi), *CoCoS* segnala *“NO recommended scenarios!”* e non modifica il file `H_M.txt`. Il comportamento è utile per individuare coppie poco informative o profili troppo scarsi.

== Collegamento ai moduli successivi

I prototipi compositi (insieme di proprietà con il relativo grado + *scenario score*) alimentano il classificatore e il recommender: sono riutilizzati per ranking e spiegazioni, mantenendo trasparenza sui tratti ereditati e sullo scenario selezionato.