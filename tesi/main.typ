#import "unito-template/lib.typ": template
// Typst: Preview PDF

#let abstract = [
  Questo lavoro presenta un sistema intelligente di raccomandazione musicale basato sulla combinazione di concetti. Il sistema utilizza testi e caratteristiche stilistiche dei brani, acquisiti e arricchiti tramite un crawler automatico di Genius, per costruire prototipi di genere e ibridi cross-genere. La pipeline implementata comprende moduli di analisi delle ripetizioni, generazione di prototipi concettuali e un classificatore che sfrutta “anchors” e soglie adattive per selezionare i contenuti più rilevanti. L’approccio proposto coniuga trasparenza e interpretabilità, fornendo raccomandazioni spiegabili e adattabili a diversi scenari musicali.
]

#let acknowledgments = [
  Desidero esprimere la mia sincera gratitudine al Prof. Gian Luca Pozzato per la sua guida e supporto durante lo sviluppo di questa tesi. Un ringraziamento speciale va anche ai miei amici e familiari per il loro incoraggiamento costante.
]

#show: template.with(
  title: "Raccomandazione di contenuti musicali: un sistema intelligente basato sulla combinazione di concetti",
  academic-year: [2024/2025],
  subtitle: "Tesi di Laurea Triennale",

  candidate: (name: "Alberto Marocco", matricola: 947841),
  supervisor: ("Prof. Pozzato Gian Luca"),
  co-supervisor: (),

  affiliation: (
    university: "Università degli Studi di Torino",
    school: "Dipartimento di Informatica",
    degree: "Corso di Laurea in Informatica",
  ),

  lang: "it",
  logo: image("imgs/logo.svg", width: 40%),

  bibliography: bibliography("works.yml"),

  // Lasciali al loro posto nel template
  abstract: abstract,
  acknowledgments: acknowledgments,

  keywords: ["ai", "typst", "tesi"]
)

// Capitoli veri
//#include "../chapters/2.Indice.typ"
#include "../chapters/3.Introduzione.typ"
#include "../chapters/8.AnalisiEConclusioni.typ"
