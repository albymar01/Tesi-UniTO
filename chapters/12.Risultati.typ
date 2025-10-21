
= Risultati

In questo capitolo sintetizziamo gli esiti della pipeline: prototipi ibridi → classificatore/recommender per ciascuna coppia *HEAD/MODIFIER*. Gli output sono file `H_M_recommendations.json` che, per ogni coppia, riportano: categoria, prototipo (proprietà selezionate), *ancore* (rigide/forti), lista dei brani consigliati con le proprietà effettivamente colpite e i contatori `classified`/`total`.

== Metriche e formato

Ogni file espone:
- `prototype`: proprietà del concetto ibrido (es. `["trap","high_repetition","metal"]`);
- `anchors`: sottoinsieme di proprietà chiave usate come vincoli/ancore;
- `results`: brani con `matches` (proprietà colpite) e `anchors_hit` (ancore soddisfatte);
- `classified` / `total`: copertura della classificazione per la coppia.

*Esempio (estratto trap–metal).*  
`prototype = ["trap","high_repetition","metal"]`, `classified = 48`, `total = 48`.

== Copertura

Sulle coppie analizzate, la copertura è *piena* in vari casi (`classified = total = 48`; es. *trap–metal*, *rap–rnb*).  
In accoppiamenti con profili più scarsi, la copertura può ridursi (casi ~79% osservati su *rock–reggae*), coerentemente con assenza di scenari in *CoCoS* o con proprietà insufficienti nel prototipo.

== Coerenza dei suggerimenti con il prototipo

*Trap–Metal.* Il prototipo ibrido enfatizza `trap`, `metal`, `high_repetition`. Nei risultati:
- tracce *trap* colpiscono `trap` + `high_repetition` e spesso soddisfano entrambe le *ancore*;
- brani *metal* colpiscono `metal` + `high_repetition`;
- altri generi compaiono quando soddisfano l’ancora `high_repetition`, a conferma del ruolo trasversale del segnale di ripetizione.

*Rap–RNB.* Il prototipo enfatizza `rnb` + `high_repetition`. I suggerimenti includono brani R&B con ritornello marcato e, per la componente di ripetizione, anche rap/pop/rock con *hook* forti quando colpiscono l’ancora.

== Interpretazione

*Ancore forti funzionano bene.* Dove il prototipo contiene proprietà altamente distintive (es. `trap`, `metal`, `rnb`) la lista privilegia brani emblematici dei generi coinvolti, mantenendo diversità lungo l’asse `high_repetition`.

*Segnali trasversali spiegano intersezioni ampie.* `high_repetition` porta in alto anche brani di altri generi con *chorus/hook* forti: è coerente con i tag generati nell’enrichment.

== Esempi puntuali

- *Trap–Metal* → brano che colpisce `high_repetition` e `trap`: `anchors_hit = ["high_repetition","trap"]`.
- *Metal–Trap* → brano che colpisce `high_repetition` e `metal`: `anchors_hit = ["high_repetition","metal"]`.
- *Rap–RNB* → brano che colpisce `high_repetition` e `rnb`: `anchors_hit = ["high_repetition","rnb"]`.
- *Rap–RNB* → brano con sola `high_repetition`: entra per la forza dell’*hook* pur non essendo R&B.

== Limiti osservati

*Dipendenza da `high_repetition`.* Essendo un segnale “orizzontale”, può allargare troppo la platea se il prototipo non contiene altre tipiche/rigide selettive; l’effetto è utile per esplorare *cross-over*, ma va bilanciato in presentazione.

*Copertura non uniforme.* Dove i profili di genere sono scarsi (poche tipiche/rigide) la selezione può risultare vuota o parziale (casi *NO scenario* in *CoCoS* e coperture < 100% a valle).

== Takeaway

Il recommender preserva le scelte di *CoCoS*: le *ancore* del prototipo ibrido guidano effettivamente i suggerimenti.  
I tag di ripetizione arricchiti da Genius si riflettono nei risultati, favorendo brani con *hook/chorus* marcati anche fuori dal macro-genere dell’*HEAD/MODIFIER*.  
Con profili più ricchi (più tipiche non trasversali) ci si attende maggiore precisione semantica e minore dipendenza da `high_repetition`.
