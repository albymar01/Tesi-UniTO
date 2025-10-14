= Estrazione e pre-processing dei dati (Genius)

In questo capitolo descriviamo come sono stati raccolti e preparati i dati testuali (brani e metadati) da Genius.com, usando la libreria Python `lyricsgenius` per l’accesso all’API e uno script di enrichment per stimare l’indice di ripetizione e derivare tag ausiliari. :contentReference[oaicite:0]{index=0}

== Accesso all’API Genius e gestione del token
Per il recupero (o integrazione) dei testi utilizziamo `lyricsgenius`, un client Python che interfaccia sia la *Developer API* (`api.genius.com`) sia la *Public API* di Genius. L’accesso autenticato richiede un *access token* impostato come variabile d’ambiente `GENIUS_TOKEN` (token non versionato nel codice). Installazione: `pip install lyricsgenius`. Uso tipico: istanza `Genius(...)` con opzioni di rate limiting / timeout. :contentReference[oaicite:1]{index=1}

== Raccolta dei brani: criteri e formato di output
La raccolta è guidata da una lista di brani per genere (rap, metal, rock, pop, trap, reggae, rnb, country). Per ciascun brano, quando disponibile, persistiamo un record nel JSON unico (`descr_music_GENIUS.json`) con i campi principali:
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
  "moods": [],
  "instruments": [],
  "subgenres": ["rap"],
  "contexts": [],
  "repetition": { "rep_ratio": 0.576, "has_chorus_like": 0, "has_hook_like": 0 }
}

I campi title/artist/album/year provengono da Genius; lyrics contiene il testo integrale (se presente o recuperabile). Il canale tags è usato anche per i segnali di ripetizione derivati nel pre-processing (sezione seguente). 
lyricsgenius.readthedocs.io

== Enrichment della ripetizione e tag derivati
Lo script enrich_repetition.py elabora il testo e aggiunge al record un blocco repetition con:

Indice di ripetizione $ "rep_ratio" = 1 - frac(text("vocab_size"), text("token_count")) \in [0,1] $ su testo normalizzato;


n-gram più frequenti (top_terms, top_bigrams, top_trigrams);

Flag euristici has_chorus_like / has_hook_like (densità n-gram, eventuali etichette [Chorus]/[Hook]).
In base a questi indici arricchiamo tags con: high_repetition (se $ text("rep_ratio") \ge 0.25 $), catchy_chorus e/o hook_repetition.
 L’arricchimento è idempotente e il JSON viene riscritto con commit atomico. (Questi segnali alimentano le proprietà tipiche usate da TCL/CoCoS nei capitoli successivi.)

== Nota sulla variante “extended”
È stata sperimentata una variante extended che, a partire dai prototipi per brano e dai profili typical/rigid, genera per ogni canzone un JSON dedicato (piano di struttura/strumentazione, focus lirico, lyrics da Genius). Per semplicità di integrazione nella pipeline, nella versione finale è stato adottato il JSON unico; la variante è mantenuta come utilità per analisi qualitative.
