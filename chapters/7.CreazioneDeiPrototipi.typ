= Creazione dei prototipi (Modulo 1)
In questo capitolo si descrive come, a partire dal JSON `descr_music_GENIUS.json`, vengono generati i prototipi testuali per ciascun brano. Il modulo produce un file `.txt` per ogni istanza (artwork/brano) con coppie `parola: punteggio` normalizzate nell’intervallo `[0.6, 0.9]`, compatibile con il range atteso dalle proprietà *tipiche* in *TCL*.

== Input e obiettivo

*Input.* Lista di record con campi minimi: `ID`, `title`, `artist`, `album`, `year`, `lyrics`, `tags`, `moods`, `instruments`, `subgenres`, `contexts`.  
*Output.* Per ogni istanza `ID`, un file `/<cartella>/<ID>.txt` con feature lessicali pesate, destinato ai moduli successivi (*CoCoS* e Recommender).

== Pre-processing linguistico


- *Tokenizzazione.* `nltk.tokenize.word_tokenize` (Treebank + Punkt).  
- *Stopword.* Rimozione delle stopword inglesi (corpus NLTK).  
- *Lemmatizzazione & POS.* Quando disponibile, *TreeTagger* via `treetaggerwrapper` (lemma + POS); in fallback, lowercasing senza lemma.  
- *Regola leggera di co-occorrenza.* Se in bigramma compare un *verbo (lemma)* seguito da un *sostantivo/parola di contenuto*, oltre al lemma del sostantivo si incrementa anche il conteggio del verbo (cattura associazioni *verbo → tema*).

== Estrazione e pesatura delle feature
Per ogni istanza si costruisce una “descrizione” concatenando i campi configurati (`title`, `artist`, `lyrics`, `tags`, …); il testo è tokenizzato/lemmatizzato e si contano le occorrenze grezze.  
I conteggi sono trasformati in punteggi tramite *normalizzazione lineare* sull’intervallo `[0.6, 0.9]`:

$ text("score") = 0.6 + 0.3 * frac(text("freq") - text("min_freq"), text("max_freq") - text("min_freq")) $

dove $ text("freq") = frac(text("count")(w), text("tot_words")) $.  
Se $ text("max_freq") = text("min_freq") $, si assegna $ text("score") = 0.9 $ (tutti i termini al valore massimo nel caso degenerato).

== Formato dell’output

Un file per istanza, una riga per parola (spaziatura allineata per leggibilità):
rap:        0.645
lookin:     0.627
god:        0.624
feel:       0.615
...

L’`ID` dell’istanza determina il nome del file (sanificato per il filesystem).

== Esempio sintetico
Estratto (rap, *Rap God*):  
`rap: 0.645 · lookin: 0.627 · god: 0.624 · feel: 0.615 · ...`  
(La lista completa è nel file generato in `music_for_cocos`.)

== Considerazioni implementative
- *Robustezza.* Se *TreeTagger* non è disponibile, il modulo prosegue con tokenizzazione + stopword (senza lemma/POS).  
- *Pulizia.* Normalizzazione `title/artist` (minuscolizzazione, trimming) e deduplicazione per `genius_id`.  
- *Riproducibilità.* Parametri e soglie sono fissati nel codice; i file sono scritti in modo idempotente.