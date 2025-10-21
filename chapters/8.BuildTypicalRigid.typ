
= Costruzione delle proprietà tipiche e rigide (Modulo 2)

In questo capitolo descriviamo come il modulo `BuildTypicalRigid.py` costruisce, per ciascun macro-genere, due insiemi di proprietà: *rigide* (vincoli non derogabili) e *tipiche* (inclusioni con grado), a partire dal JSON dei brani generato nel preprocessing di Genius. Il risultato alimenta il preprocessing di *CoCoS* e la successiva combinazione *HEAD/MODIFIER*.

== Scopo e dati di ingresso
- *Scopo.* Per ogni macro-genere si producono due file: `typical/<genere>.txt` (righe `proprieta: peso`) e `rigid/<genere>.txt` (una proprietà per riga).
- *Input.* Un JSON con i brani (titolo, artista, lyrics, `tags`, eventuali `subgenres`), da cui si calcolano frequenze documentali per tag e parole.
- *Output.* Insiemi compatti e bilanciati di tratti caratteristici: le *rigide* come ancore forti, le *tipiche* come proprietà con grado `p in [0.60, 0.95]` normalizzato per *CoCoS*.

== Mappatura dei generi e vocabolario
- *Macro-generi.* L’analisi avviene su un set di macro-generi predefinito (es. `rap`, `metal`, `rock`, `pop`, `trap`, `reggae`, `rnb`, `country`).
- *Da subgenere a macro-genere.* Una mappa `SUB2MACRO` ricondurrà etichette come `hip_hop`, `boom_bap`, `drill` a `rap`; `dancehall` a `reggae`; ecc. Inoltre si controllano `title`/`album`/`artist` per eventuali occorrenze indicative.
- *Token testuali (lyrics).* Si estraggono parole “utili” con una regex alfabetica (≥ 3 caratteri), normalizzando minuscole/apostrofi. Si filtra una stoplist inglese, ma un `DOMAIN_WHITELIST` preserva termini di dominio (es. `hiphop`, `808`, `trap`, `metal`, `hook_repetition`, `catchy_chorus`, `high_repetition`).

== Pipeline di calcolo (per genere)
1. *Partizionamento.* Ogni brano è assegnato a uno o più macro-generi usando `subgenres`, `tags` e, in seconda battuta, il testo di `title`/`album`/`artist`.
2. *Document frequency.* Per ciascun genere si calcolano DF di `tags` e di parole (dalle lyrics). Per le parole si applica `min_df_words` per scartare termini troppo rari.
3. *Frazione di presenza.* Si ottiene, per ogni proprietà `p` nel genere `g`, la frazione `frac(p,g) = df(p,g) / N_g`, dove `N_g` è il numero di brani del genere.
4. *Selezione “raw”.* Entrano candidati *tipici*:
   - `tags` con `frac >= typical_thr_tags`;
   - parole con `frac >= typical_thr_words`, escludendo globalità come `high_repetition` se non nel `DOMAIN_WHITELIST`.
5. *Scoring delle tipiche.* Per ogni candidato si combina *prevalenza* nel genere e *specificità* cross-genere (tipo-IDF), con peso `ALPHA`:
   - `score ≈ ALPHA * frac + (1-ALPHA) * (frac / idf)`; alle parole si applica un fattore di prudenza (es. `0.8`).
   - Penalità ai tratti molto globali (`COMMON_PENALTY`) e *boost* alle proprietà distintive che compaiono in pochi generi (`DISTINCTIVE_BOOST` con soglia `DISTINCTIVE_MAX_GENRES`).
6. *Top-k e normalizzazione.* Si prendono le `topk_typical` proprietà per score; quindi si normalizzano i pesi nell’intervallo `[MIN_W, MAX_W]` (default `0.60..0.95`) con min–max scaling (caso degenerato → `0.80`).
7. *Scelta delle rigide.*
   - `tags` con `frac >= rigid_thr_tags`;
   - parole con `frac >= rigid_thr_words` ma *solo* se presenti nel `DOMAIN_WHITELIST`;
   - si limita a `max_rigid`, preservando l’ordine di apparizione (ancore concise e robuste).
8. *Scrittura file.*
   - `typical/<genere>.txt` contiene righe `proprieta: peso` ordinate per peso decrescente (poi lessico);
   - `rigid/<genere>.txt` elenca le proprietà rigide (una per riga).

== Differenze tra *TAG* e *WORD*
- I *TAG* (es. `high_repetition`, `catchy_chorus`) derivano dai metadati/arricchimenti e tendono a essere segnali puliti; possono diventare facilmente *rigide* se ubiqui nel genere.
- Le *WORD* provengono dalle lyrics, sono più rumorose: per questo c’è `min_df_words` e un fattore prudenziale nello scoring; inoltre diventano *rigide* solo se ricadono nel `DOMAIN_WHITELIST` e superano `rigid_thr_words`.

== Iperparametri e impatto pratico
- `typical_thr_tags` / `typical_thr_words`: alzare le soglie rende i *typical* più selettivi (meno proprietà, più pulizia); abbassarle amplia la copertura (più proprietà, più rumore).
- `rigid_thr_tags` / `rigid_thr_words`: soglie alte creano *rigide* davvero onnipresenti; soglie più basse aumentano le ancore ma rischiano di vincolare eccessivamente *CoCoS*.
- `min_df_words`: alzare riduce il rumore lessicale; abbassare permette a più termini informativi di entrare.
- `topk_typical`: più alto → più materiale per *CoCoS* (scenari più ricchi), ma potenziale rumore; più basso → tipiche più “forti” ma minor varietà.
- `max_rigid`: più alto → più ancore (scenari più vincolati, rischio “NO scenario”); più basso → più flessibilità (ma ancore meno protettive).
- `ALPHA`: se cresce, il profilo privilegia la prevalenza interna al genere; se diminuisce, enfatizza la specificità (tratti distintivi cross-genere).
- `COMMON_PENALTY`, `DISTINCTIVE_MAX_GENRES`, `DISTINCTIVE_BOOST`: controllano rispettivamente la penalità ai tratti “orizzontali”, la soglia per considerare distintiva una proprietà e l’entità del boost.
- `MIN_W`, `MAX_W`: fissano il range finale dei pesi tipici (coerente con `p in (0.5,1]` per l’uso in *TCL*).

== Esempio di esecuzione e lettura dei risultati
Esecuzione (parametri lievemente più permissivi rispetto ai default “strict”):
`python BuildTypicalRigid.py --input "<base>/descr_music_GENIUS.json" --out "<base>" --typical_thr_tags 0.80 --rigid_thr_tags 0.98 --typical_thr_words 0.80 --rigid_thr_words 0.98 --min_df_words 8 --topk_typical 6 --max_rigid 2`

- Confronto con i default “strict”: `typical_thr_*` da `0.85`→`0.80` (più copertura), `min_df_words` da `10`→`8` (più termini candidati), `topk_typical` da `5`→`6` (più tipiche), `max_rigid` da `3`→`2` (meno ancore, più flessibilità).
- Effetto atteso su *CoCoS*: più tipiche disponibili per scenario, minore rischio di over-constrain grazie a `max_rigid` più basso; potenziale aumento di scenari ammissibili e minore frequenza di “NO scenario”.

== Buone pratiche
- Preferire poche *rigide* molto robuste (due o tre) e un set di *tipiche* bilanciato (5–8) per genere.
- Se compaiono troppe proprietà “orizzontali” (es. `high_repetition`), valutare un `COMMON_PENALTY` più forte o aumentare `typical_thr_words`.
- Se i profili risultano poveri, abbassare moderatamente `typical_thr_*` e/o `min_df_words` e aumentare `topk_typical`, verificando a valle l’impatto su *CoCoS*.
