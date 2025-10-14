= Creazione dei prototipi (Modulo 1)

In questo capitolo descriviamo come, a partire dal JSON `descr_music_GENIUS.json`, vengono generati i prototipi testuali per brano. Il modulo produce un file `.txt` per artwork/istanza con coppie `parola: punteggio` normalizzate in [0.6, 0.9].

== Input e obiettivo

*Input.* Lista di record con campi minimi: `ID`, `title`, `artist`, `album`, `year`, `lyrics`, `tags`, `moods`, `instruments`, `subgenres`, `contexts`.  
*Output.* Per ogni istanza `ID`, un file `<ID>.txt` con feature lessicali pesate, destinato ai moduli successivi (CoCoS e Recommender).

== Pre-processing linguistico

*Tokenizzazione:* con `nltk.tokenize.word_tokenize`, il tokenizer raccomandato da NLTK (Treebank+Punkt).  


*Stopword:* rimozione delle stopword inglesi dal corpus NLTK.  

*Lemmatizzazione & POS:* quando disponibile, si usa TreeTagger via `treetaggerwrapper` (tag POS e lemma); in fallback, si abbassa a lowercase senza lemma.  


*Regola leggera di co-occorrenza.* Se compare un verbo `lemma` seguito da un sostantivo/parola “contenuto”, oltre al lemma del sostantivo si incrementa anche il conteggio del verbo (cattura associazioni verbo→tema).

== Estrazione e pesatura delle feature

Per ogni istanza si concatena una “descrizione” dai campi configurati (titolo, artista, lyrics, tags, …), si tokenizza/lemmatizza e si contano le occorrenze grezze.  
I conteggi sono trasformati in punteggi tramite normalizzazione lineare sull’intervallo [0.6, 0.9]:

$ text("score") = 0.6 + (0.9 - 0.6) * frac(text("freq") - text("minFreq"), text("maxFreq") - text("minFreq")) $

dove $ text("freq") = frac(text("count")(w), text("totWords")) $;  
se $ text("maxFreq") = text("minFreq") $, si assegna $ text("score") = 0.9 $.

== Formato dell’output

Un file per istanza, una riga per parola:  
`word: 0.66`  
Allineamento spaziato per leggibilità; l’`ID` dell’istanza determina il filename (sanificato per Windows).

== Esempio sintetico

Estratto (rap *Rap God*):  
`rap: 0.645 · lookin: 0.627 · god: 0.624 · --: 0.618 · feel: 0.615 …`  
(La lista completa è nel file generato in `music_for_cocos`.)

== Considerazioni implementative

*Robustezza:* se TreeTagger non è disponibile, il modulo prosegue senza lemma/POS (solo tokenizzazione+stopword).  

*Strumenti citati:* TreeTagger (POS/lemma multilingue) e `treetaggerwrapper` (wrapper Python); NLTK per tokenizzazione e stopword.
