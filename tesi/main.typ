// Importa il template principale
#import "unito-template/lib.typ": template

// ---------- Abstract ----------
#let abstract = [
#v(8pt)
La seguente tesi di laurea presenta *DEGARI-Music*, un sistema di raccomandazione
musicale basato sulla combinazione concettuale e sulla tipicità. I testi e le caratteristiche stilistiche dei brani,
raccolti e arricchiti attraverso un crawler automatico di Genius.com, vengono preprocessati per
estrarre feature lessicali e segnali di ripetizione; da essi si costruiscono prototipi
di genere con proprietà *rigide* e *tipiche*. La combinazione HEAD/MODIFIER è
realizzata con il framework *TCL* e il tool *CoCoS*, che generano scenari
ponderati e prototipi ibridi impiegati per classificazione, ranking e spiegazioni.
Un classificatore spiegabile, basato su "anchors" e soglie adattive, filtra e ordina
i brani; le raccomandazioni risultano interpretabili sulla base dei tratti e dello scenario selezionato.
L’approccio coniuga trasparenza, riproducibilità e potenziale estendibilità a
multilingua, feature audio e apprendimento dei pesi. 
]

// ---------- Ringraziamenti ----------
#let acknowledgments = [
Desidero ringraziare innanzitutto il professor Gian Luca Pozzato per la disponibilità e per avermi dato la possibilità 
di lavorare su questo progetto interessante, nonostante i tempi stretti con le scadenze 

Un ringraziamento profondo  ai miei genitori, per il sostegno costante e la pazienza dimostrata in questi anni, 
soprattutto nei momenti in cui non ero sicuro del percorso che stavo affrontando.  
La loro presenza mi ha permesso di superare le difficoltà e di arrivare a questo traguardo.

Ringrazio anche i miei amici e colleghi per i confronti, le risate e il supporto quotidiano, dentro e fuori l’università.  
Il loro incoraggiamento ha reso questo percorso più leggero e ricco di soddisfazioni.

Infine, grazie a tutte le persone che, anche solo con una parola o un gesto, mi hanno accompagnato lungo il cammino e mi hanno aiutato ad arrivare fin qui.
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

#include "../chapters/5.TCLeStrumenti.typ"
#pagebreak(weak: true)

#include "../chapters/6.EstrazioneDeiDatiGenius.typ"
#pagebreak(weak: true)

#include "../chapters/7.CreazioneDeiPrototipi.typ"
#pagebreak(weak: true)

#include "../chapters/8.BuildTypicalRigid.typ"
#pagebreak(weak: true)

#include "../chapters/9.PreprocessingCocos.typ"
#pagebreak(weak: true)

#include "../chapters/10.CoCos.typ"
#pagebreak(weak: true)

#include "../chapters/11.SistemaDiRaccomandazione.typ"
#pagebreak(weak: true)

#include "../chapters/12.Risultati.typ"
#pagebreak(weak: true)

#include "../chapters/13.Discussione.typ"
#pagebreak(weak: true)

#include "../chapters/14.ConclusioniESviluppiFuturi.typ"
#pagebreak(weak: true)

//bibliografia e ringraziamenti finali
//fine del documento