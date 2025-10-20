= Estrazione e pre-processing dei dati (Genius)

In questo capitolo vengono descritte la raccolta e la preparazione dei dati testuali (testi e metadati) da *Genius*, l’uso del client Python `lyricsgenius` per l’accesso all’API e uno script di *enrichment* per stimare indici di ripetizione e derivare tag ausiliari.

== Accesso all’API Genius e gestione del token
Per il recupero o l’integrazione dei testi viene utilizzato `lyricsgenius`, un client Python che interfaccia la *Developer API* (`api.genius.com`) e la *Public API*. L’accesso autenticato richiede un *access token* impostato come variabile d’ambiente `GENIUS_TOKEN` (token non versionato nel codice). In fase di istanziazione (`Genius(...)`) sono configurati timeout e rate-limit; il codice gestisce retry su errori temporanei (ad es. HTTP 429) ed evita duplicati per brano/ID.

== Raccolta dei brani: criteri e formato di output
La raccolta è guidata da una lista di brani per genere (rap, metal, rock, pop, trap, reggae, rnb, country). Per ciascun brano si persiste, quando disponibile, un record nel JSON unico `descr_music_GENIUS.json` con i campi principali:
{
  "ID": "rap_eminem_rap-god_2013_235729",
  "genius_id": 235729,
  "source": "genius",
  "source_url": "https://genius.com/Eminem-rap-god-lyrics",
  "title": "Rap God",
  "artist": "Eminem",
  "album": "Curtain Call 2",
  "year": "2013",
  "lyrics": "Testo integrale ...",
  "tags": ["high_repetition", "rap"],
  "moods": [ ],
  "instruments": [ ],
  "subgenres": ["rap"],
  "contexts": [ ],
  "repetition": { "rep_ratio": 0.576, "has_chorus_like": 0, "has_hook_like": 0 }
}

I campi `title/artist/album/year` provengono da *Genius*; `lyrics` contiene il testo integrale (se presente). La chiave `tags` è usata anche per i segnali di ripetizione derivati nel pre-processing (sezione seguente). Sono previsti controlli di *deduplicazione* per `genius_id` e normalizzazione di `title/artist` (minuscolizzazione, trimming) per gestire alias e varianti.


== Enrichment della ripetizione e tag derivati
Lo script `enrich_repetition.py` elabora il testo e aggiunge al record un blocco `repetition` con:

- *Indice di ripetizione* `rep_ratio`, compreso tra 0 e 1, calcolato come *1 meno il rapporto tra il numero di lemmi distinti e il numero totale di lemmi* dopo normalizzazione del testo.
- *n-gram più frequenti* (`top_terms`, `top_bigrams`, `top_trigrams`).
- *Flag euristici* `has_chorus_like` / `has_hook_like`, basati su densità di n-gram e su eventuali etichette testuali come `[Chorus]` o `[Hook]`.

In base a questi indici si arricchisce `tags` con:
- `high_repetition` (se `rep_ratio ≥ 0.25`);
- `catchy_chorus` e/o `hook_repetition` quando i flag sono attivi.

La soglia `0.25` è scelta in modo conservativo dopo ispezioni qualitative su più generi: valori inferiori generano troppi falsi positivi su testi prolissi, mentre valori troppo alti escludono casi con ritornelli brevi.  
L’arricchimento è *idempotente* e il JSON viene riscritto con *commit atomico* (scrittura temporanea e rinomina del file finale).  
Questi segnali alimentano le *proprietà tipiche* utilizzate da *TCL/CoCoS* nei capitoli successivi.

== Nota sulla variante “extended”

È stata sperimentata una variante *extended* che, a partire dai prototipi per brano e dai profili *typical/rigid*, genera per ogni canzone un *JSON dedicato* (piano di struttura/strumentazione, focus lirico, *lyrics*).  
Per semplicità di integrazione nella pipeline, nella versione finale è stato adottato il JSON unico; la variante è mantenuta come utilità per analisi qualitative.
