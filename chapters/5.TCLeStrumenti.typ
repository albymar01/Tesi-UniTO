= Probabilità e strumenti per la combinazione concettuale (TCL e CoCoS)

In questo capitolo approfondiamo (i) la componente probabilistica di TCL e (ii) il tool CoCoS che implementa la combinazione concettuale basata su tipicità, presentando anche sistemi affini riutilizzatori di CoCoS.

== Inclusioni probabilistiche e scenari in TCL

In TCL le proprietà tipiche sono annotate con un grado di credenza:
$ p :: T(C) subset.eq.sq D, quad p in (0.5, 1] $.
L’idea è che le tipicità valgano “per i $C$ normali”, ma possano essere sospese di fronte a informazione più specifica. La semantica probabilistica (stile DISPONTE) assume indipendenza fra tipicità e definisce una distribuzione sugli *scenari*, cioè sulle scelte di quali inclusioni tipiche sono attive.

*Definizione operativa.* Data una base con tipicità $p_i :: T(C_i) subset.eq.sq D_i$:
- uno *scenario* è un sottoinsieme consistente delle tipicità;
- allo scenario si associa un punteggio/probabilità ottenuto combinando i $p_i$ (attive) e $(1 - p_i)$ (escluse);
- si selezionano gli scenari *ammessi* dalle rigide e *coerenti* con l’euristica HEAD/MODIFIER; il/i prototipo/i del concetto composto eredita/no le proprietà presenti nello/gli scenario/i selezionato/i.

Questa lettura si integra con la *rational closure* di ALC+TR: gli scenari sono valutati solo sui modelli che minimizzano l’eccezionalità, preservando specificità e irrilevanza.

== CoCoS: input, algoritmo, output

*Scopo.* CoCoS implementa TCL: dato un concetto HEAD $C_H$ e un MODIFIER $C_M$, costruisce gli scenari ammissibili e restituisce il prototipo del concetto composto $C_H \land C_M$.

*Input.*
- *Proprietà rigide* di $C_H$ e $C_M$ (vincoli non derogabili).
- *Proprietà tipiche* con grado $p$ per ciascun concetto.
- (Opzionale) limiti al numero massimo di proprietà da ereditare.

*Algoritmo (sketch).*
1. *Genera scenari*: combina le tipicità in insiemi consistenti con le rigide.
2. *Valuta*: assegna a ogni scenario un punteggio/probabilità (ipotesi di indipendenza).
3. *Filtra HEAD/MODIFIER*: scarta scenari incompatibili con la dominanza semantica dell’HEAD.
4. *Seleziona*: sceglie lo/gli scenario/i migliore/i; produce una mappa *proprietà → grado* per il prototipo composito e annota la probabilità/score di scenario.

*Output.* Un file *Result* con la mappa delle proprietà ereditate (e.g., `{rock: 0.95, high_repetition: 0.8, ...}`) e le info di scenario; opzionale *Scenario* con la maschera delle tipicità attive.

== Sistemi affini e riuso di CoCoS

La stessa combinazione basata su TCL è stata riusata in diversi prototipi per creatività computazionale e XAI (ad es. supporto alla generazione di personaggi/ruoli, raccomandazione culturale). Esempi recenti includono estensioni di DEGARI e strumenti come *EDIFICA* e *GOCCIOLA*, che si appoggiano a CoCoS per la fase di combinazione.

== Collocazione nella pipeline della tesi

Nei capitoli successivi useremo TCL/CoCoS come “motore” di combinazione: dopo la costruzione dei prototipi di base (proprietà rigide/tipiche), combineremo HEAD/MODIFIER per ottenere concetti ibridi; questi prototipi composti alimenteranno classificazione e ranking.
