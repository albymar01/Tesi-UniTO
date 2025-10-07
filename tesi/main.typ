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
#include "../chapters/3.Introduzione.typ"
#include "../chapters/4.Sviluppo.typ"
#include "../chapters/5.Risultati.typ"
#include "../chapters/6.ConclusioniESviluppiFuturi.typ"
