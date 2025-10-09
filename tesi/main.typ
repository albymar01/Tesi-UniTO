// Importa il template principale
#import "unito-template/lib.typ": template

// ---------- Abstract ----------
#let abstract = [
  Questo lavoro presenta un sistema intelligente di raccomandazione musicale
  basato sulla combinazione di concetti. Il sistema utilizza testi e caratteristiche
  stilistiche dei brani, acquisiti e arricchiti tramite un crawler automatico di Genius,
  per costruire prototipi di genere e ibridi cross-genere. La pipeline implementata
  comprende moduli di analisi delle ripetizioni, generazione di prototipi concettuali
  e un classificatore che sfrutta “anchors” e soglie adattive per selezionare i
  contenuti più rilevanti. L’approccio proposto coniuga trasparenza e interpretabilità,
  fornendo raccomandazioni spiegabili e adattabili a diversi scenari musicali.
]

// ---------- Ringraziamenti ----------
#let acknowledgments = [
  Desidero esprimere la mia sincera gratitudine al Prof. Gian Luca Pozzato per
  la sua guida e supporto durante lo sviluppo di questa tesi. Un ringraziamento
  speciale va anche ai miei amici e familiari per il loro incoraggiamento costante.
]

// ---------- Mostra il template ----------
#show: template.with(
  // Titolo e info accademiche
  title: "Raccomandazione di contenuti musicali: un sistema intelligente basato sulla combinazione di concetti",
  academic-year: [2024/2025],
  subtitle: "Tesi di Laurea Triennale",

  // Candidato e relatore
  candidate: (name: "Alberto Marocco", matricola: 947841),
  supervisor: ("Prof. Gian Luca Pozzato"),
  co-supervisor: (),

  // Affiliazione
  affiliation: (
    university: "Università degli Studi di Torino",
    school: "Dipartimento di Informatica",
    degree: "Corso di Laurea in Informatica",
  ),

  // Impostazioni lingua e logo
  lang: "it",
  logo: image("imgs/logo.svg", width: 40%),

    // Attiva la sezione finale Bibliografia + Ringraziamenti
  // (usa l’elenco manuale già previsto nel template)
  bib: "../works.yml",

  // Abstract e ringraziamenti
  abstract: abstract,
  acknowledgments: acknowledgments,

  // (Facoltativo) parole chiave
  keywords: ["AI", "Typst", "Tesi", "Raccomandazione Musicale"]
)

// ---------- Capitoli ----------
//Frontespizio, Dichiarazione di originalità, Abstract, Indice e poi:
#include "../chapters/3.Introduzione.typ"
#pagebreak(weak: true)

#include "../chapters/4.FondamentiTeorici.typ"
#pagebreak(weak: true)

//Questo capitolo l'ho riassunto cosi ma dentro lo chiamerei Probabilità per la combinazione: il framework TCL e gli strumenti
#include "../chapters/5.TCLeStrumenti.typ"
#pagebreak(weak: true)

//Questo l'ho chiamo poi Estrazione e pre-processing dei dati (Genius)
#include "../chapters/6.EstrazioneDeiDatiGenius.typ"
#pagebreak(weak: true)

//qua a me piace così senza citare modulo nel titolo
#include "../chapters/7.CreazioneDeiPrototipi.typ"
#pagebreak(weak: true)

//qua l'8 è da miglioare
#include "../chapters/8.CoCoSCombinazioneGeneri.typ"
#pagebreak(weak: true)

//anche qua serve il titolo migliore dimmelo
#include "../chapters/9.ClassificatoreESpiegazioni.typ"
#pagebreak(weak: true)

//lascerei appunto separato
#include "../chapters/10.SistemaDiRaccomandazione.typ"
#pagebreak(weak: true)

//da qui in poi dimmi se manca altro
#include "../chapters/11.Risultati.typ"
#pagebreak(weak: true)

#include "../chapters/12.Discussione.typ"
#pagebreak(weak: true)

#include "../chapters/13.ConclusioniESviluppiFuturi.typ"
#pagebreak(weak: true)

//bibliografia e ringraziamenti finali
//fine del documento