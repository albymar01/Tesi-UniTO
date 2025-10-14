= Preprocessing CoCoS: costruzione dei file H_M (Modulo 3a)

In questo capitolo descriviamo il preprocessing che, a partire dai profili per genere (cartelle typical/ e rigid/ prodotte dal Modulo 2), costruisce i file di input per CoCoS in prototipi_music/, uno per ogni coppia Head–Modifier (H_M.txt).

== Scopo, input e percorsi

Script. Sistema di raccomandazione/cocos_preprocessing.py
Config. cocos_config.py (percorsi TYPICAL_PROP_DIR, RIGID_PROP_DIR, COCOS_DIR).

Input.

typical/<genere>.txt: righe prop: peso (es. high_repetition: 0.80).

rigid/<genere>.txt: una proprietà per riga (ancore non derogabili).

Output.

prototipi_music/H_M.txt con:

intestazione (titoli Head/Modifier),

rigide di head e modifier,

tipiche annotate come T(head), prop, p e T(modifier), prop, p.

== Algoritmo (cocos_preprocessing.py)

Legge rigid e typical per head e modifier.

Scrive H_M.txt in COCOS_DIR con il seguente ordine:

intestazione Title, Head Concept Name, Modifier Concept Name;

blocco rigid dell’head (head, <prop>), poi del modifier (modifier, <prop>);

blocco typical del modifier (T(modifier), <prop>, <peso>);

blocco typical dell’head (T(head), <prop>, <peso>).

L’ordine rigid → T(modifier) → T(head) è coerente con il ruolo Head/Modifier usato da CoCoS nel modulo successivo.


== Esecuzione

Su una coppia specifica:  
`python cocos_preprocessing.py <HEAD> <MODIFIER>`

Batch su tutte le coppie (H ≠ M).  
Vedi snippet PowerShell già usato:

SNIPPET CHE NON IRESCO AD INCOCLLARE


== Formato del file H_M.txt (esempi)

country–metal:

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


metal–country (simmetrico ma invertiti i ruoli):

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

Le rigid sono riportate come vincoli duri e saranno sempre rispettate da CoCoS.

I pesi delle typical vengono copiati dai file di genere (range tipico [0.6, 0.95]).

È utile generare sia H_M.txt sia M_H.txt: l’esito della combinazione dipende dal ruolo Head/Modifier.

I percorsi sono centralizzati in cocos_config.py (ad es. COCOS_DIR per la destinazione dei file).

== Collegamento al Modulo 3b

I file H_M.txt prodotti qui sono consumati da cocos.py, che costruisce gli scenari di combinazione, seleziona i best e li appende al file (oltre a generare, se richiesto, un JSON con gli scenari raccomandati).