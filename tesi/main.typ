// Importa il template principale
#import "unito-template/lib.typ": template

// ---------- Abstract ----------
#let abstract = [
Questo lavoro presenta DEGARI-Music, un sistema content-based di raccomandazione
musicale basato sulla combinazione concettuale e sulla tipicità. I testi dei brani,
raccolti e arricchiti tramite un crawler su Genius, vengono preprocessati per
estrarre feature lessicali e segnali di ripetizione; da questi si costruiscono prototipi
di genere (proprietà rigide e tipiche). La combinazione HEAD/MODIFIER è
realizzata con il framework TCL e il tool CoCoS, che generano scenari
ponderati e prototipi ibridi impiegati per classificazione, ranking e spiegazioni.
Un classificatore spiegabile, basato su anchors e soglie adattive, filtra e ordina
i brani; le raccomandazioni risultano interpretabili a livello di tratti e di scenario.
L’approccio coniuga trasparenza, riproducibilità e potenziale estendibilità a
multilingua, feature audio e apprendimento dei pesi.
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

// Spaziatura per i level-2 (==) in tutto il documento
#show heading.where(level: 2): set block(above: 1.4em, below: 0.7em)

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
#include "../chapters/8.BuildTypicalRigid.typ"
#pagebreak(weak: true)

//anche qua serve il titolo migliore dimmelo
#include "../chapters/9.PreprocessingCocos.typ"
#pagebreak(weak: true)

//lascerei appunto separato
#include "../chapters/11.SistemaDiRaccomandazione.typ"
#pagebreak(weak: true)

//da qui in poi dimmi se manca altro
#include "../chapters/12.Risultati.typ"
#pagebreak(weak: true)

#include "../chapters/13.Discussione.typ"
#pagebreak(weak: true)

#include "../chapters/14.ConclusioniESviluppiFuturi.typ"
#pagebreak(weak: true)

//bibliografia e ringraziamenti finali
//fine del documento