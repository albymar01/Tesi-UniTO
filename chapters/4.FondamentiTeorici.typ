= Fondamenti teorici: tipicità e combinazione di concetti (TCL)


== Tipicità e chiusura razionale

Le *Logiche Descrittive* (DL) forniscono un formalismo per rappresentare concetti, ruoli e individui. Nelle DL classiche (ad es. *ALC*) il ragionamento è *monotono*: aggiungere nuova informazione non invalida ciò che è già derivabile. Questo comportamento è inadeguato per modellare la conoscenza “di buon senso”, spesso caratterizzata da regole generali con eccezioni.

Per modellare regolarità con eccezioni si introduce l’operatore di *tipicità* $T(\cdot)$: un’assioma del tipo $T(C) subset.eq.sq D$ indica che “tipicamente i $C$ sono $D$”. Le inclusioni *rigide* conservano la forma classica $C subset.eq.sq D$.

La *rational closure* estende alle DL la chiusura razionale: i concetti vengono ordinati per grado di eccezionalità e si adottano *modelli minimi* che minimizzano i ranghi di anomalia. In questo modo le inferenze su $T(\cdot)$ sono conservative, ma consentono di sospendere premesse tipiche quando emergono informazioni più specifiche (ereditarietà difettibile).

=== Notazione di base
- Inclusioni rigide: $C subset.eq.sq D$.
- Inclusioni tipiche: $T(C) subset.eq.sq D$.
- Preferenza semantica: si privilegiano interpretazioni che minimizzano l’eccezionalità (modelli minimi) e rispettano la gerarchia di specificità.

== TCL: Typicality-based Compositional Logic

*TCL* combina tipicità, probabilità e combinazione concettuale in stile cognitivo. Le proprietà tipiche sono annotate con un grado:
$ p :: T(C) subset.eq.sq D, , p in (0.5, 1] $
che si legge: “con grado $p$, i $C$ tipici sono $D$”.

Dato un *HEAD* $C_H$ e un *MODIFIER* $C_M$, la combinazione produce un concetto composto che non è la semplice intersezione, ma il risultato di una selezione coerente delle proprietà:
1. *Generazione di scenari*: si costruiscono insiemi compatibili di inclusioni tipiche (rispettando tutte le rigide).
2. *Valutazione*: ad ogni scenario si associa un punteggio/probabilità ottenuto combinando le annotazioni delle tipicità considerate attive (ipotesi d’indipendenza sui pesi tipici).
3. *Selezione*: si scelgono gli scenari ammessi e meglio valutati; le proprietà del risultato sono quelle presenti nello/gli scenario/i selezionato/i.

=== Ruolo HEAD / MODIFIER
- L’HEAD fornisce la struttura concettuale di base; in caso di conflitti tra tipicità, hanno priorità le rigide e, tra le tipiche, si privilegiano scelte coerenti con la “fisionomia” dell’HEAD.
- Il MODIFIER introduce restrizioni/aggiustamenti che possono soppiantare tratti non essenziali dell’HEAD se questo aumenta la coerenza globale dello scenario.

=== Perché serve TCL (il “pet–fish”)
La combinazione concettuale umana non è additiva: esistono congiunzioni in cui la tipicità dell’insieme composto supera quella dei componenti (es. *pet fish*). Approcci puramente fuzzy o intersezioni rigide non catturano questi effetti; l’uso di tipicità difettibili, modelli minimi e scenari pesati consente invece di selezionare combinazioni plausibili senza contraddizioni.

== Semantica probabilistica delle tipicità

Le annotazioni $p$ sulle inclusioni tipiche possono essere interpretate in modo “distribuzionale”: uno scenario eredita un punteggio combinando (sotto ipotesi d’indipendenza) i pesi delle tipicità attive e penalizzando quelle escluse o in conflitto. Questa lettura consente di ordinare gli scenari e di spiegare perché alcune combinazioni risultano più plausibili di altre dal punto di vista qualitativo e quantitativo.

== Il sistema CoCoS (cenni)

CoCoS implementa il calcolo di scenari di TCL. Dati HEAD e MODIFIER con le rispettive proprietà rigide e tipiche, costruisce gli scenari ammissibili, ne calcola il punteggio e restituisce il/i prototipo/i del concetto composto come mappa proprietà → grado, insieme alle informazioni sullo scenario selezionato. (Questa sezione introduce solo l’idea operativa; i dettagli implementativi saranno trattati nei capitoli successivi.)
