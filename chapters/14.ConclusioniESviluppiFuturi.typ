= Conclusioni e sviluppi futuri

Chiudiamo la tesi riassumendo i contributi principali, i risultati emersi e le direzioni che riteniamo più promettenti.

== Conclusioni

Contributo metodologico.
Abbiamo mostrato che una pipeline leggera, interamente spiegabile, può supportare la combinazione concettuale di generi musicali:

raccolta ed enrichment dei testi da Genius con stima della ripetizione;

prototipi per brano con pesi normalizzati;

costruzione di profili typical/rigid per macro-genere;

preprocessing Head/Modifier e combinazione con CoCoS (scenari pesati in stile TCL);

raccomandatore che classifica e spiega i suggerimenti sulla base dei tratti ereditati dallo scenario selezionato.

Trasparenza.
Ogni raccomandazione è accompagnata da: rigid rispettate, tipiche attivate e score di scenario. Questo consente auditabilità e controllo fine (es. agendo sulle soglie o sul ruolo Head/Modifier).

Risultati pratici.
La pipeline ha prodotto prototipi ibridi plausibili per molte coppie di generi, con copertura piena nel classificatore e spiegazioni coerenti con i profili. Dove i profili sono ricchi, CoCoS propone più scenari sensati; dove sono poveri, prevalgono segnali trasversali (ad es. high_repetition), confermando l’importanza della cura delle typical distintive.

Limiti.
(i) dipendenza dalla qualità di testi/metadata e dalle mappe SUB2MACRO;
(ii) ipotesi di indipendenza dei pesi tipici nello scoring degli scenari;
(iii) ruoli Head/Modifier talvolta troppo rigidi;
(iv) scarsa multilingua: l’intera pipeline è tarata sull’inglese (tokenizzazione, stoplist, tagger).

== Sviluppi futuri

Multilingua (priorità).

Portare l’estrazione e i prototipi a più lingue (italiano in primis): tokenizzazione, stoplist e lemmatizzazione per lingua;

normalizzazione cross-lingua delle proprietà (sinonimi, varianti morfologiche) e mapping dei tag;

scelta dinamica del modello in base alla lingua del brano e possibilità di mix multilingua.

Feature audio e metadata strutturati.

Integrare deskriptor audio (tempo stimato, energy, spectral features) e campi strutturati (anno, provenienza, mood editoriali) come typical aggiuntive o vincoli rigid;

fusione tardo/early con pesi apprendibili dal feedback.

Apprendimento dei pesi e dei vincoli.

Stimare automaticamente gradi typical e regole di co-occorrenza/antagonismo tra proprietà (dipendenze) a partire dai dati;

active learning per far correggere al curatore gli scenari e aggiornare i profili.

Arricchimento lessicale e mapping di genere.

Ampliare DOMAIN_WHITELIST e SUB2MACRO, includendo slang e sottogeneri emergenti;

usare embedding per consolidare sinonimi e ridurre la frammentazione del vocabolario.

CoCoS più espressivo.

Scenari con gruppi coerenti di feature (es. se trap allora 808) e penalità per combinazioni incoerenti;

plasticità del ruolo Head/Modifier e scelta automatica del verso più naturale (H/M o M/H) per ogni coppia.

Valutazione su utenti.

Studio utente e A/B test sulle spiegazioni: misurare fiducia, utilità percepita e qualità del discovery;

metriche di diversità/novità nelle playlist ibride e confronto con baseline neurali o collaborative.

Tooling e riproducibilità.

Report automatici di copertura, proprietà mai attivate e bottleneck di scenario;

packaging della pipeline con config condivisibili e seed fissati per esperimenti ripetibili.

In sintesi, la tesi dimostra che prototipi + combinazione tipica è un paradigma efficace e trasparente per generare crossover musicali spiegabili. Con multilingua, feature audio e apprendimento dei pesi, il sistema può diventare uno strumento pratico di curation e discovery per playlist, editoria e creatività assistita.