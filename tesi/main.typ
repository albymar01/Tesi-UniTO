#import "unito-template/lib.typ": template
// Typst: Preview PDF

// Esempi (puoi riscriverli o rimuoverli)
#let acknowledgments = [
  Grazie a tutti per il supporto nello sviluppo di questa tesi.
]

#let abstract = [
  Questo è un abstract di prova: descrive in breve obiettivi e risultati.
]

#show: template.with(
  // Frontespizio
  title: "Titolo della Tesi",
  academic-year: [2024/2025],
  subtitle: "Tesi di Laurea Triennale",

  candidate: (name: "Alberto Marocco", matricola: 947841),
  supervisor: ("Prof. Pozzato Gian Luca"),
  co-supervisor: (), // oppure: ("Dott. Nome Correlatore")

  affiliation: (
    university: "Università degli Studi di Torino",
    school: "Dipartimento di Informatica",
    degree: "Corso di Laurea in Informatica",
  ),

  lang: "it",
  logo: image("imgs/logo.svg", width: 40%),

  // Biblio: usa works.yml (Hayagriva) già incluso nel progetto
  bibliography: bibliography("works.yml"),

  acknowledgments: acknowledgments,
  abstract: abstract,

  keywords: ["ai", "typst", "tesi"]
)


//#include "../chapters/1.Estratto.typ"
//#include "../chapters/2.Indice.typ"
#include "../chapters/3.Introduzione.typ"
#include "../chapters/8.AnalisiEConclusioni.typ"
//#include "../chapters/9.RiferimentiBibliografici.typ"
