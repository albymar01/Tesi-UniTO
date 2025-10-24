// ========== UniTO Thesis Template (Typst) ==========

// Dichiarazione di originalità (IT/EN)
#let declaration-of-originality = (
  "en": [
    I declare to be responsible for the content I'm presenting in order to obtain the final degree, not to have plagiarized in all or part of, the work produced by others and having cited original sources in consistent way with current plagiarism regulations and copyright. I am also aware that in case of false declaration, I could incur in law penalties and my admission to final exam could be denied
  ],
  "it": [
    Dichiaro di essere responsabile del contenuto dell'elaborato che presento al fine del conseguimento del titolo, di non avere plagiato in tutto o in parte il lavoro prodotto da altri e di aver citato le fonti originali in modo congruente alle normative vigenti in materia di plagio e di diritto d'autore. Sono inoltre consapevole che nel caso la mia dichiarazione risultasse mendace, potrei incorrere nelle sanzioni previste dalla legge e la mia ammissione alla prova finale potrebbe essere negata.
  ]
)

// ========== Template ==========
#let template(
  title: [Thesis Title],
  academic-year: [2023/2024],
  subtitle: [Bachelor's Thesis],

  paper-size: "a4",

  candidate: (),
  supervisor: "",
  co-supervisor: (),

  affiliation: (),

  lang: "en",

  // Qui passiamo l'oggetto bibliografia caricato dal main: bib: bibliography("works.yml")
  bib: none,

  logo: none,
  abstract: none,
  acknowledgments: none,
  keywords: none,

  body
) = {
  // Metadati e stile
  set document(title: title, author: candidate.name)
  set text(font: "New Computer Modern", lang: lang, size: 12pt)
  set page(
    paper: paper-size,
    margin: (right: 3cm, left: 3.5cm, top: 3.5cm, bottom: 3.5cm)
  )

  // Matematica e blocchi raw
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  show raw.where(block: true): set text(size: 0.8em, font: ("Consolas", "Courier New"))
  show raw.where(block: true): set par(justify: false)
  show raw.where(block: true): block.with(
    fill: gradient.linear(luma(240), luma(245), angle: 270deg),
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )
  show raw.where(block: false): box.with(
    fill: gradient.linear(luma(240), luma(245), angle: 270deg),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  show figure.caption: set text(size: 0.8em)
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt, marker: ([•], [--]))

  set heading(numbering: "1.a.I")
  show heading.where(level: 1): it => {
    if it.body not in ([References], [Riferimenti]) {
      block(width: 100%, height: 20%)[
        #set align(center + horizon)
        #set text(1.3em, weight: "bold")
        #smallcaps(it)
      ]
    } else {
      block(width: 100%, height: 10%)[
        #set align(center + horizon)
        #set text(1.1em, weight: "bold")
        #smallcaps(it)
      ]
    }
  }
  show heading.where(level: 2): it => block(width: 100%)[
    #set align(center)
    #set text(1.1em, weight: "bold")
    #smallcaps(it)
  ]
  show heading.where(level: 3): it => block(width: 100%)[
    #set align(left)
    #set text(1em, weight: "bold")
    #smallcaps(it)
  ]

  // Frontespizio
  set align(center)
  block[
    #let jb = linebreak(justify: true)
    #text(1.5em, weight: "bold", affiliation.university) #jb
    #text(1.2em, [
      #smallcaps(affiliation.school) #jb
      #affiliation.degree #jb
    ])
  ]

  v(3fr)
  if logo != none { logo }
  v(3fr)

  text(1.5em, subtitle)
  v(1fr, weak: true)
  text(2em, weight: 700, title)

  v(4fr)

grid(
  columns: 2,
  align: left,
  grid.cell(inset: (right: 40pt))[
    #if lang == "en" { smallcaps("supervisor") } else { smallcaps("relatore") }\
    *#supervisor*
  ],
  grid.cell(inset: (left: 40pt))[
    #if lang == "en" { smallcaps("candidate") } else { smallcaps("candidato") }\
    *#candidate.name* \
    #candidate.matricola
  ]
)


  v(5fr)
  text(1.2em, [
    #if lang == "en" { "Academic Year " } else { "Anno Accademico " }
    #academic-year
  ])

  // Dichiarazione, abstract, indice
  pagebreak(weak: true)
  set par(justify: true, first-line-indent: 1em)
  set align(center + horizon)

  heading(level: 2, numbering: none, outlined: false,
    if lang == "en" { "Declaration of Originality" } else { "Dichiarazione di Originalità" }
  )
  text(style: "italic", declaration-of-originality.at(lang))

  pagebreak(weak: true)

  if abstract != none {
    heading(level: 2, numbering: none, outlined: false, "Abstract")
    abstract
  }

  pagebreak(weak: true)

  // Indice
  show outline.entry.where(level: 1): it => {
    if it.body() not in ([References], [Riferimenti]) {
      v(12pt, weak: true)
      link(it.element.location(), strong({
        it.body()
        h(1fr)
        it.page()
      }))
    } else {
      text(size: 1em, it)
    }
  }
  show outline.entry.where(level: 3): it => { text(size: 0.8em, it) }
  outline(depth: 3, indent: auto)

  // Corpo principale
  pagebreak(to: "odd")
  show link: underline
  set page(numbering: "1")
  set align(top + left)
  counter(page).update(1)
  body

   // Sezioni finali: Bibliografia e Ringraziamenti
  pagebreak(to: "odd")

if bib != none {
  // Titolo personalizzato (uno solo)
  heading(
    level: 1,
    numbering: none,
    if lang == "en" { "References" } else { "Bibliografia / Sitografia" }
  )

  // Spaziatura e stile generale
  v(10pt)
  set par(justify: false, leading: 1.15em)
  set text(size: 11pt, lang: lang)
  set enum(
    indent: 0em,
    body-indent: 1em,
    numbering: "[1]",
  )
  // Stile link compatibile con Typst 0.13
  show link: set text(fill: rgb(60%, 60%, 60%))

  // Bibliografia formattata (senza titolo interno)
  bibliography(bib, full: true, title: none)
}

pagebreak(weak: true);


    if acknowledgments != none {
      //pagebreak(to: "odd")
      heading(level: 1, numbering: none, outlined: false,
        if lang == "en" { "Acknowledgments" } else { "Ringraziamenti" }
      )
      acknowledgments
    }
  }
}
