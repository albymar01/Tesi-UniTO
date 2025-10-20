= CoCoS: combinazione e scenari (Modulo 3b)

In questo capitolo descriviamo l’esecuzione di *CoCoS* sul set di coppie *HEAD/MODIFIER* generato dal preprocessing. L’obiettivo è selezionare gli scenari migliori e scrivere il prototipo del concetto ibrido (es. *rock–trap*).

== Input e avvio

*Input.* Per ogni coppia *H_M* è presente un file `prototipi_music/H_M.txt` con:

intestazione: *Head Concept Name*, *Modifier Concept Name*;

rigide di *head* e *modifier* (provenienti da `rigid/`);

tipiche annotate come righe del tipo `T(head|modifier), proprietà, p` con *p* in $(0.5, 1]$ (provenienti da `typical/`).

*CLI.* Esecuzione batch (esempio usato nel progetto):

`python .\cocos.py "<BASE>\prototipi_music\H_M.txt" 3 -o "<BASE>\prototipi_music\scenarios_json"`

Il secondo argomento (qui 3) sovrascrive il default e impone il massimo numero di tipiche ereditabili.

== Generazione e scoring degli scenari

Dalle tipiche disponibili si costruiscono sottoinsiemi ammissibili (nel rispetto delle *rigid* e del limite sugli attributi).
A ciascuno scenario si assegna uno *score* in stile *DISPONTE*: lo *score* è calcolato come prodotto dei gradi *p* delle tipicità attive (assunzione di indipendenza).
Gli scenari sono ordinati per *score*; in caso di parità si mantengono più *best*.

== Selezione e output

Per ogni file `H_M.txt`:

a console vengono stampati gli scenari raccomandati;

nel file stesso si appendono due righe riepilogative:

Result: {\"rock\": 0.95, \"trap\": 0.95, \"hook_repetition\": 0.60, \"＠scenario_score\": 3.4656}
Scenario: [1, 1, 0, 1, 0, 3.4656]

Con l’opzione `-o` si salva anche un JSON in `prototipi_music/scenarios_json/` con tutti i *best*.

Esempio. Per *rock–trap* uno scenario raccomandato può essere:
Result: {\"rock\": 0.95, \"trap\": 0.95, \"hook_repetition\": 0.60, \"＠scenario_score\": 3.4656}

Per coppie poco informative o con profili scarsi si può ottenere:
*NO recommended scenarios!*

== Parametri pratici

*MAX_ATTRS.* Numero massimo di tipiche ereditabili (default nel config, sovrascrivibile da CLI).
*Coerenza HEAD/MODIFIER.* Le *rigid* di entrambi si rispettano sempre; tra le *typical* si privilegiano combinazioni coerenti con la fisionomia dell’*HEAD*, lasciando al *MODIFIER* aggiustamenti compatibili.
*Fall-back.* Se nessuno scenario supera i vincoli, il file non viene modificato: questo aiuta a individuare coppie o profili da rivedere.

== Output per i moduli successivi

I *Result* (insieme di proprietà con relativo grado + *score* di scenario) sono l’input del classificatore e del recommender: forniscono sia i tratti ereditati sia la *forza* dello scenario selezionato, riutilizzata per *ranking* e spiegazioni.
