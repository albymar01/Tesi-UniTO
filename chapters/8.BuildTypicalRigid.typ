= Combinazione di generi musicali con CoCoS (Modulo 2)

In questo capitolo descriviamo come, a partire dalle proprietà rigide e tipiche per macro-genere, CoCoS costruisce scenari di combinazione HEAD/MODIFIER e seleziona i prototipi dei concetti ibridi (es. pop–rap).

== Input, preprocessing e formato dei file

Input. Le directory typical/ e rigid/ prodotte dal Modulo 2, più la cartella dei .txt per coppia H_M in prototipi_music (creata da cocos_preprocessing.py).
Ogni file H_M.txt contiene:

intestazione con Head Concept Name e Modifier Concept Name,

elenco delle rigide di head e modifier,

inclusioni tipiche annotate come $ p :: T(C) subset.eq.sq D $ (pesi in $ (0.5, 1] $).

Esempio sintetico (pop–rap).

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

Le rigide di entrambi i concetti vanno sempre rispettate.

Tra le tipiche, CoCoS privilegia scenari coerenti con la fisionomia dell’HEAD; il MODIFIER introduce aggiustamenti compatibili (cfr. TCL nel cap. 2–3).

Un limite al numero di tipiche selezionabili (parametro MAX_ATTRS in cocos_config.py, default 2) evita combinazioni “sovraccariche”.

== Generazione e valutazione degli scenari

Dalle tipicità disponibili si costruiscono sottoinsiemi ammissibili (rispetto a rigide e al limite `MAX_ATTRS`).
A ciascuno scenario si associa uno *score* in stile DISPONTE (indipendenza dei pesi tipici):

$ text("score")(S) = ∏_{i ∈ S} p_i $


Gli scenari sono ordinati per score; in caso di parità si mantengono più best.

== Selezione e output

Per ciascun file H_M.txt:

si stampano a console gli scenari raccomandati;

si appendono al file due righe:

Result: `{ ... proprietà → peso ..., "@scenario_probability": score }`

Scenario: `[ ... bitmask ..., score ]`

Opzionale: con `-o` si salva un JSON pulito in `prototipi_music/scenarios_json/` con tutti i *best*.

Esempio di risultato (*pop–rap*):

`Result: {"pop": 0.95, "high_repetition": 0.8, "hook_repetition": 0.629, "@scenario_probability": 7.0941136, "@scenario_score": 7.0941136}`  
`Scenario: [1, 1, 0, 1, 0, 7.0941136]`



== Parametri rilevanti

MAX_ATTRS in cocos_config.py (default 2): massimo numero di tipiche ereditabili.

CLI (cocos.py):

esecuzione su tutta la cartella configurata: python cocos.py

esecuzione su una coppia: python cocos.py path\H_M.txt 3 -o path\scenarios_json

== Casi senza scenario

Se nessuno scenario supera i vincoli (rigide, coerenza, limite di attributi), CoCoS segnala “NO recommended scenarios!” e non modifica il file H_M.txt. Questo comportamento è utile per evidenziare coppie poco informative o profili troppo scarsi.

== Collegamento ai moduli successivi

I prototipi compositi (proprietà → grado + scenario score) alimentano il classificatore e il recommender: sono usati per spiegazioni e ranking, mantenendo trasparenza sui tratti ereditati e sullo scenario scelto.