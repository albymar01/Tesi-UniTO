
= Preprocessing CoCoS: costruzione dei file H_M (Modulo 3a)

Il preprocessing genera i file di input per CoCoS partendo dai profili per genere prodotti nel Modulo 2 (`typical/` e `rigid/`), costruisce i file di input per *CoCoS* in `prototipi_music/`, uno per ogni coppia *Head/Modifier* (`H_M.txt`).

== Scopo, input e percorsi

*Script.* `Sistema di raccomandazione/cocos_preprocessing.py`  
*Config.* `cocos_config.py` (percorsi `TYPICAL_PROP_DIR`, `RIGID_PROP_DIR`, `COCOS_DIR`).

*Input.*
- `typical/<genere>.txt`: righe nel formato `prop: peso` (es. `high_repetition: 0.80`).
- `rigid/<genere>.txt`: una proprietà per riga (vincoli non derogabili).

*Output.*
- `prototipi_music/H_M.txt` con:
  - intestazione (titoli *Head/Modifier*);
  - *rigide* di *head* e *modifier*;
  - *tipiche* annotate come `T(head), <prop>, <p>` e `T(modifier), <prop>, <p>`.

== Algoritmo (`cocos_preprocessing.py`)

1. Legge i file `rigid` e `typical` per *HEAD* e *MODIFIER*.  
2. Scrive `H_M.txt` in `COCOS_DIR` con il seguente ordine:
   - intestazione: `Title`, `Head Concept Name`, `Modifier Concept Name`;
   - blocco *rigide* dell’*head* (`head, <prop>`), poi del *modifier* (`modifier, <prop>`);
   - blocco *tipiche* del *modifier* (`T(modifier), <prop>, <peso>`);
   - blocco *tipiche* dell’*head* (`T(head), <prop>, <peso>`).

L’ordine `rigid → T(modifier) → T(head)` è coerente con il ruolo *HEAD/MODIFIER* usato da *CoCoS* nel modulo successivo.

== Esecuzione

- *Singola coppia:*  
  `python cocos_preprocessing.py <HEAD> <MODIFIER>`

- *Batch su tutte le coppie (H ≠ M) – PowerShell:*

`genres = @("rap","metal","rock","pop","trap","reggae","rnb","country")
foreach ($h in $genres) {
  foreach ($m in $genres) {
    if ($h -ne $m) {
      python cocos_preprocessing.py $h $m
    }
  }
}`

== Esempio di file `H_M.txt`

#image("../Immagini/TrapMetal.png", width: 60%)

== Formato del file `H_M.txt` (esempi)

*country–metal*  
Title: country-metal  
Head Concept Name: country  
Modifier Concept Name: metal

head, country  
head, high_repetition

modifier, metal  
modifier, high_repetition

T(modifier), metal, 0.95  
T(modifier), high_repetition, 0.6

T(head), country, 0.95  
T(head), high_repetition, 0.6


*metal–country* (simmetrico, ruoli invertiti)  
Title: metal-country  
Head Concept Name: metal  
Modifier Concept Name: country

head, metal  
head, high_repetition

modifier, country  
modifier, high_repetition

T(modifier), country, 0.95  
T(modifier), high_repetition, 0.6

T(head), metal, 0.95  
T(head), high_repetition, 0.6

== Note pratiche

- Le *rigide* sono riportate come _vincoli duri_ e saranno sempre rispettate da *CoCoS*.  
- I pesi delle *tipiche* sono copiati dai file di genere (range tipico `[0.60, 0.95]`).  
- È utile generare sia `H_M.txt` sia `M_H.txt`: l’esito dipende dal ruolo *Head/Modifier*.  
- I percorsi sono centralizzati in `cocos_config.py` (es. `COCOS_DIR` per la destinazione dei file).

== Collegamento al Modulo 3b

I file `H_M.txt` costituiscono l’input diretto per il modulo 3b (`cocos.py`), che esegue la combinazione logica con *CoCoS*, genera gli scenari ammessi e li appende ai file di origine insieme ai punteggi.  
Questa fase chiude la preparazione dei dati e apre la parte di *combinazione concettuale vera e propria* descritta nel capitolo seguente.
