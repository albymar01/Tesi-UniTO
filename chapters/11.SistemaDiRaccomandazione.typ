= Sistema di raccomandazione (Modulo 4)

Il modulo finale prende i prototipi ibridi generati da *CoCoS* e filtra/ordina i brani del dataset originale, producendo per ogni coppia *HEAD_MODIFIER* un file JSON con gli item consigliati e l’evidenza delle proprietà soddisfatte.

== Input e panoramica

*Input.*

I file `prototipi_music/H_M.txt` arricchiti da *CoCoS* (rigide, tipiche e righe finali `Result:` e `Scenario:`).

Il JSON sorgente dei brani configurato in `Recommender_config.py` (stessi campi usati nei moduli precedenti).

*Output.*
Per ogni `H_M.txt` viene salvato un `H_M_recommendations.json` con: categoria, prototipo attivo, ancore, lista dei risultati id–titolo–artista–matches–anchors_hit, numero di brani classificati su totale. Gli output vengono poi spostati in `prototipi_music/recommender_out/`.

== Dal file CoCoS al prototipo “pulito”

Il classificatore legge `Result:` e l’array `Scenario:` del file `H_M.txt` e costruisce il prototipo attivo:

- seleziona le tipiche con bit 1 nello scenario;
- include le ancore (le rigide del file e, più in generale, le proprietà marcate obbligate nella sezione iniziale);
- rimuove duplicati e normalizza i nomi.

Il risultato è una lista di proprietà da soddisfare + l’insieme delle ancore richieste.

== Regole di matching

Per ogni brano del JSON sorgente il sistema:

- cerca ogni proprietà del prototipo nei campi configurati in `Recommender_config.py` (titolo + campi descrittivi);
- opzionalmente scarta il brano se contiene proprietà negate (prefisso `-` nel file prototipo);
- accetta il brano se sono vere entrambe le soglie:
  - `match-rate` minimo (default 0.15 delle proprietà del prototipo),
  - minimo numero di ancore colpite (default 1).

Le soglie sono modificabili da CLI:
`--min-match-rate`, `--min-anchors` (e `--max-print` per limitare le righe stampate a console).

== Formato dell’output

Ogni JSON contiene:
- `category` (nome del file prototipo, es. `head_modifier.txt`),
- `prototype` (lista piatta delle proprietà del prototipo attivo),
- `anchors` (ancore richieste),
- `results` (array di oggetti { id, title, artist, matches, anchors_hit }),
- `classified` e `total`.

Esempio sintetico (rock_pop):
`{
"category": "rock_pop.txt",
"prototype": ["rock","hook_repetition","catchy_chorus","pop","high_repetition"],
"anchors": ["catchy_chorus","rock","high_repetition","pop","hook_repetition"],
"results": [
{ "id": "...rap-god...", "title": "Rap God", "artist": "Eminem",
"matches": ["high_repetition"], "anchors_hit": ["high_repetition"] }
],
"classified": 48, "total": 48
}`

== Uso a riga di comando e integrazione nella pipeline

*Singolo prototipo.*
`python Sistema di raccomandazione/Classificatore/Recommender.py prototipi_music\H_M.txt`

*Batch su tutte le coppie.*
Lo script PowerShell del progetto itera su tutti i `H_M.txt`, invoca il classificatore e sposta gli output nella cartella `recommender_out/`.

== Considerazioni e limiti

*Spiegabilità.* Ogni suggerimento riporta le proprietà che hanno fatto match e quali ancore sono state colpite.

*Ranking.* L’attuale versione filtra per soglie e non ordina con uno score continuo; in prospettiva si può introdurre un ranking per numero/`peso` di proprietà soddisfatte (es. riusando i pesi tipici di *CoCoS*).

*Parametri.* Le soglie di copertura e ancore permettono di rendere il sistema più `severo` o `inclusivo` senza modificare i prototipi di partenza.

*Coerenza.* Se *CoCoS* non aveva prodotto scenari per una coppia, non esiste un `Result:` valido e non viene generato alcun JSON di raccomandazioni per quella categoria.

== Collegamento ai capitoli successivi

I JSON di raccomandazione alimentano sia i *Risultati* sia le *Spiegazioni*, dove analizziamo copertura, varietà e casi tipici di match per le combinazioni testate.
