= Risultati

In questo capitolo sintetizziamo gli esiti della pipeline: prototipi compositi → classificatore/raccomandatore per ciascuna coppia HEAD/MODIFIER. Gli output sono file *recommendations.json che, per ogni coppia, riportano: categoria, prototipo (proprietà selezionate), ancore rigide/forti, lista dei brani consigliati con le proprietà effettivamente colpite, e contatori classified/total.*

== Metriche e formato

Ogni file espone:

prototype: proprietà del concetto ibrido (es. ["trap","high_repetition","metal"]).

anchors: sottoinsieme di proprietà chiave usate come vincoli/ancore.

results: brani con matches (proprietà colpite) e anchors_hit (ancore soddisfatte).

classified / total: copertura della classificazione per la coppia.

Esempio (estratto trap–metal): prototype = ["trap","high_repetition","metal"], classified = 48, total = 48.

== Copertura

Sulle coppie analizzate, la copertura è piena in molti casi (classified = total = 48, es. trap–metal, rap–rnb).
In alcuni accoppiamenti con profili più scarsi, la copertura può ridursi (casi ~79% osservati a log su rock–reggae), coerente con l’assenza di scenari o proprietà insufficienti nel prototipo.

== Coerenza dei suggerimenti con il prototipo

Trap–Metal. Il prototipo ibrido punta su trap, metal, high_repetition. Nei risultati:

tracce trap (Travis Scott, Future) colpiscono trap + high_repetition e soddisfano entrambe le ancore quando presenti (anchors_hit: trap, high_repetition);

classici metal (Metallica, Judas Priest) colpiscono metal + high_repetition;

brani di altri generi appaiono quando soddisfano comunque l’ancora di ripetizione (es. Weeknd, AC/DC, Marley), a conferma del ruolo trasversale di high_repetition.

Rap–R&B. Il prototipo enfatizza rnb + high_repetition. I suggerimenti includono Beyoncé e TLC (hit di rnb + high_repetition) e, per la componente di ripetizione, anche rap/pop/rock con forte hook (Eminem, Weeknd, AC/DC) quando soddisfano l’ancora.

== Interpretazione

Ancore forti funzionano bene. Dove il prototipo contiene proprietà altamente distintive (es. trap, metal, rnb) la lista privilegia brani emblematici dei generi coinvolti, mantenendo diversità sul terzo asse (high_repetition).

Segnali trasversali spiegano intersezioni ampie. high_repetition porta nella top anche brani di altri generi con forte chorus/hook: spiegazione coerente con i tag generati nell’enrichment.

== Esempi puntuali

Trap–Metal → “SICKO MODE” (Travis Scott). matches = ["high_repetition","trap"], anchors_hit = ["high_repetition","trap"].
Metal → “Enter Sandman” (Metallica). matches = ["high_repetition","metal"], anchors_hit = ["high_repetition","metal"].

Rap–R&B → “Drunk in Love” (Beyoncé). matches = ["high_repetition","rnb"], anchors_hit = ["high_repetition","rnb"].
Rap–R&B → “Rap God” (Eminem). matches = ["high_repetition"], richiamato dalla forte ripetizione anche se non rnb.

== Limiti osservati

Dipendenza da high_repetition. Essendo un segnale orizzontale, può allargare troppo la platea se il prototipo non contiene altre tipiche/rigide selettive; l’effetto è voluto per esplorare cross-over, ma va bilanciato in fase di presentazione.

Copertura non uniforme. Dove i profili di genere sono scarsi (poche tipiche/rigide) la selezione può risultare vuota o parziale (casi “NO scenario” in CoCoS e coperture < 100% a valle).

== Takeaway

Il raccomandatore preserva le scelte di CoCoS: le ancore del prototipo ibrido guidano effettivamente i suggerimenti.

I tag di ripetizione arricchiti su Genius si riflettono nei risultati, favorendo brani con hook/chorus marcati anche fuori dal macro-genere dell’HEAD/MODIFIER.

Con profili più ricchi (più tipiche non trasversali) ci si attende una maggiore precisione semantica e minore dipendenza da high_repetition.