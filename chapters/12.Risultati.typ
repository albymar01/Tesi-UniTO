= Risultati

I risultati vengono analizzati alla luce degli esiti della pipeline: prototipi ibridi → classificatore/recommender per ciascuna coppia *HEAD/MODIFIER*. Gli output sono file `H_M_recommendations.json` che, per ogni coppia, riportano: categoria, prototipo (proprietà selezionate), *ancore* (rigide/forti), lista dei brani consigliati con le proprietà effettivamente colpite e i contatori `classified`/`total`.

== Metriche e formato

Ogni file espone:
- `prototype`: proprietà del concetto ibrido (es. `["trap","high_repetition","metal"]`);
- `anchors`: sottoinsieme di proprietà chiave usate come vincoli/ancore;
- `results`: brani con `matches` (proprietà colpite) e `anchors_hit` (ancore soddisfatte);
- `classified` / `total`: copertura della classificazione per la coppia.

*Esempio (estratto trap–metal).*  
`prototype = ["trap","high_repetition","metal"]`, `anchors = ["trap","metal","high_repetition"]`, `classified = 48`, `total = 48`.

Riepilogo campi del JSON (esempio *trap–metal*):
- *Campo* → `prototype` : ``["trap","high_repetition","metal"]``
- *Campo* → `anchors` : ``["trap","metal","high_repetition"]``
- *Campo* → `classified` : ``48``
- *Campo* → `total` : ``48``

== Copertura

Nel run corrente, la copertura è *piena* su tutte le coppie (`classified = total = 48`; es. *trap–metal*, *metal–trap*, *reggae–rap*).  
In altri run o con profili più scarsi, la copertura può ridursi (es. ~79% su coppie con poche tipiche/rigide), coerentemente con assenza di scenari in *CoCoS* o con proprietà insufficienti nel prototipo.

== Riclassificazioni di brani (case–study)

=== Trap–Metal (HEAD = trap, MODIFIER = metal)

`Scenario selezionato (da "scenarios_json/trap_metal"):`  
``{ "metal": 0.95, "trap": 0.95, "high_repetition": 0.618, "＠scenario_score": 3.5695680000000003 }``  
Il prototipo ibrido enfatizza `trap`, `metal`, `high_repetition`. Le *ancore* attive sono `["trap","metal","high_repetition"]`.

＠＠FIG-TRAP-METAL-SCENARIO＠＠   // (immagine/json dello scenario consigliato)

Top-5 brani riclassificati (*trap–metal*, da `trap_metal_recommendations.json`):
1) `Rap God` — *Eminem* — `matches = ["high_repetition"]`, `anchors_hit = ["high_repetition"]`  
2) `Lose Yourself` — *Eminem* — `matches = ["high_repetition"]`, `anchors_hit = ["high_repetition"]`  
3) `Mockingbird` — *Eminem* — `matches = ["high_repetition"]`, `anchors_hit = ["high_repetition"]`  
4) `Not Like Us` — *Kendrick Lamar* — `matches = ["high_repetition"]`, `anchors_hit = ["high_repetition"]`  
5) `HUMBLE.` — *Kendrick Lamar* — `matches = ["high_repetition"]`, `anchors_hit = ["high_repetition"]`

*Lettura dei risultati.*  
- molte tracce *trap* colpiscono `high_repetition` e soddisfano l’ancora omonima;  
- l’identità *metal* resta vincolo del prototipo: i brani accettati mostrano tendenze aggressive/“dense” compatibili;  
- compaiono brani con `anchors_hit = ["high_repetition"]` quando l’*hook* è particolarmente marcato.

=== Metal–Trap (HEAD = metal, MODIFIER = trap)

`Scenario selezionato (da "scenarios_json/metal_trap"):`  
``{ "metal": 0.95, "trap": 0.95, "high_repetition": 0.618, "＠scenario_score": 3.5695680000000003 }``  
Lo scenario coincide con la direzione precedente. Anche qui `prototype = ["high_repetition","trap","metal"]` e `anchors = ["trap","metal","high_repetition"]`.

＠＠FIG-METAL-TRAP-SCENARIO＠＠   // (immagine/json dello scenario consigliato)

Top-5 brani riclassificati (*metal–trap*, da `metal_trap_recommendations.json`):
1) `Rap God` — *Eminem* — `matches = ["high_repetition"]`, `anchors_hit = ["high_repetition"]`  
2) `Lose Yourself` — *Eminem* — `matches = ["high_repetition"]`, `anchors_hit = ["high_repetition"]`  
3) `Mockingbird` — *Eminem* — `matches = ["high_repetition"]`, `anchors_hit = ["high_repetition"]`  
4) `Not Like Us` — *Kendrick Lamar* — `matches = ["high_repetition"]`, `anchors_hit = ["high_repetition"]`  
5) `HUMBLE.` — *Kendrick Lamar* — `matches = ["high_repetition"]`, `anchors_hit = ["high_repetition"]`

*Osservazione direzionale (H→M vs M→H).*  
Scenario e punteggio sono *simmetrici*. La riclassificazione concreta è però più ricca sul lato *trap→metal* (maggior disponibilità di crossover trap con tratti aggressivi) rispetto a *metal→trap*, dove i match sono spesso trainati da `high_repetition`.

=== Reggae–Rap vs Rap–Reggae

*Reggae→Rap (HEAD = reggae, MODIFIER = rap).*  
CoCoS propone più scenari coerenti, ad es.:  
``{ "reggae": 0.95, "high_repetition": 0.8, "hook_repetition": 0.6, "＠scenario_score": 7.296000000000001 }``  
``{ "reggae": 0.95, "high_repetition": 0.6, "＠scenario_score": 7.296000000000001 }``  
``{ "reggae": 0.95, "high_repetition": 0.8, "catchy_chorus": 0.6, "＠scenario_score": 7.296000000000001 }``  
Il profilo *reggae* dispone di una proprietà identitaria `reggae: 0.95` (typical) e di *rigid* `high_repetition`, `hook_repetition`: questo consente di preservare l’identità *reggae* come *ancora*, integrando segnali trasversali (`high_repetition`, `hook_repetition`) e, in misura minore, contributi da *rap*.

＠＠FIG-REGGAE-RAP-SCENARI＠＠   // (collage dei tre scenari reggae→rap)

Top-5 brani riclassificati (*reggae–rap*, da `reggae_rap_recommendations.json`):  
1) `Rap God` — *Eminem* — `matches = ["high_repetition"]`, `anchors_hit = ["high_repetition"]`  
2) `Lose Yourself` — *Eminem* — `matches = ["high_repetition"]`, `anchors_hit = ["high_repetition"]`  
3) `Mockingbird` — *Eminem* — `matches = ["high_repetition"]`, `anchors_hit = ["high_repetition"]`  
4) `Not Like Us` — *Kendrick Lamar* — `matches = ["high_repetition"]`, `anchors_hit = ["high_repetition"]`  
5) `HUMBLE.` — *Kendrick Lamar* — `matches = ["high_repetition","hook_repetition"]`, `anchors_hit = ["high_repetition","hook_repetition"]`

＊Nota＊: il `prototype` per *reggae–rap* è ``["hook_repetition","high_repetition"]`` con *ancore* ``["high_repetition","hook_repetition"]``; i brani 1–4 colpiscono solo l’ancora `high_repetition`, mentre *HUMBLE.* colpisce entrambe le ancore, risultando il caso più informativo.

*Rap→Reggae (HEAD = rap, MODIFIER = reggae).*  
Per questa direzione, CoCoS *non* genera scenari raccomandati. La ragione è strutturale:  
- *rap (HEAD)* ha profilo povero: `rap rigid = ["high_repetition"]`, `rap typical = {"high_repetition": 0.8}`;  
- non esiste una tipica identitaria `rap: 0.95` da “ancorare”;  
- imporre `reggae` come MODIFIER violerebbe il vincolo di preservare l’identità dell’HEAD (che qui non è distinguibile dal solo segnale trasversale `high_repetition`).  
Di conseguenza, la combinazione decadrebbe a un profilo *quasi generico* di ripetizione/ritornello, che *CoCoS* scarta come scenario ibrido *rap–reggae*.

＠＠BOX-NO-SCENARIO-RAP-REGGAE＠＠   // (screenshot della riga “NO recommended scenarios!”)

== Coerenza dei suggerimenti con il prototipo

*Trap–Metal.* Il prototipo ibrido enfatizza `trap`, `metal`, `high_repetition`. Nei risultati:
- tracce *trap* colpiscono `high_repetition` (e talvolta `trap`) soddisfacendo le *ancore*;  
- brani *metal* colpiscono `metal` + `high_repetition`;  
- ingressi di altri generi sono giustificati dalla forte `high_repetition`.

*Reggae–Rap.* Il mantenimento dell’identità `reggae` (tipica `reggae: 0.95` + rigide di ripetizione) spiega perché gli scenari esistono solo nella direzione *reggae→rap*.

== Esempi puntuali (ancore colpite)

- *Trap–Metal* → brano con `anchors_hit = ["high_repetition","trap"]`.  
- *Metal–Trap* → brano con `anchors_hit = ["high_repetition","metal"]`.  
- *Reggae–Rap* → brano con `anchors_hit = ["high_repetition","hook_repetition"]`.  
- *Rap–Reggae* → *nessuno scenario*: impossibile preservare un’identità *rap* distinta dal solo `high_repetition`.

== Limiti osservati

*Dipendenza da `high_repetition`.* Essendo un segnale “orizzontale”, allarga la platea se il prototipo non contiene altre tipiche/rigide selettive; l’effetto è utile per esplorare *cross-over*, ma va bilanciato.

*Copertura non uniforme.* Dove i profili di genere sono scarsi (poche tipiche/rigide), la selezione può risultare vuota o parziale (casi *NO scenario* in *CoCoS*).

== Sintesi dei risultati

Il recommender preserva le scelte di *CoCoS*: le *ancore* del prototipo ibrido guidano i suggerimenti.  
I tag di ripetizione (da enrichment) si riflettono nei risultati, favorendo brani con *hook/chorus* marcati anche fuori dal macro-genere dell’*HEAD/MODIFIER*.  
Con profili più ricchi (più tipiche non trasversali) cresce la precisione semantica e diminuisce la dipendenza da `high_repetition`.

== Indicazioni pratiche per le figure/tabelle

- Sostituire i marker `＠＠FIG-...＠＠` con gli screenshot dei JSON in `scenarios_json/` (*caption* suggerite: “Scenario selezionato per *trap–metal* / *metal–trap* / collage scenari *reggae–rap*”).  
- Le liste *Top-5* sono in forma testuale; puoi convertirle in tabelle quando preferisci.  
- Inserire uno *box* con lo screenshot della riga “NO recommended scenarios!” per *rap–reggae*.
