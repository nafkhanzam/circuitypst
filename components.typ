#import "@preview/cetz:0.2.2"

#import cetz.draw: line, circle, fill, rect

#import "parts.typ"
#import "utils.typ": anchors

#let geographical-anchors(pts) = {
  assert(
    type(pts) == "array" and pts.len() == 8,
    message: "Invalid format for geographical anchor positions " + repr(pts),
  )
  let headings = ("west", "north west", "north", "north east", "east", "south east", "south", "south west")
  for i in range(0, 8) {
    anchor(headings.at(i), pts.at(i))
  }
}



/// Resistive bipoles

/// Short circuit
/// type: path-style
/// nodename: shortshape
/// class: default
#let short = {
  line((-0.5, 0), (0.5, 0))
  anchors((
    north: (0, 0),
    south: (0, 0),
    label: (0, 0),
    annotation: (0, 0),
  ))
}

/// Resistor
/// type: path-style
/// nodename: resistorshape
/// Aliases: american resistor
/// Class: resistors
#let R = {
  let step = 1 / 6
  let height = 5 / 14
  let sgn = -1
  line(
    (-0.5, 0),
    (rel: (step / 2, height / 2)),
    ..for _ in range(5) {
      ((rel: (step, height * sgn)),)
      sgn *= -1
    },
    (0.5, 0),
    fill: none,
  )
  anchors((
    north: (0, height / 2),
    south: (0, -height / 2),
    label: (0, height),
    annotation: "south",
  ))
}


// Capacitors and inductors
// Diodes and such
// Sources and generators

/// American Current Source
/// type: path-style, fillable
/// nodename: isourceAMshape
/// aliases: american current source
/// class: sources
#let isourceAM = {
  circle((0, 0), radius: 0.5, name: "c")
  line(((-0.3, 0)), (rel: (0.6, 0)), mark-end: ">", fill: black)

  anchors((
    north: (0, 0.5),
    south: (0, -0.5),
    label: (0, 0.7),
    annotation: (0, -0.7),
  ))
}

/// Arrows

/// Arrow for current and voltage
/// type: node
#let currarrow = {
  line(
    (0.05, 0),
    (-0.05, -0.05),
    (-0.05, 0.05),
    close: true,
    fill: black,
  )
  anchors((
    north: (0, 0.05),
    south: (0, -0.05),
    east: (0.05, 0),
    west: (-0.05, 0),
  ))
}


/// Terminal shapes

/// Unconnected terminal
/// type: node
#let ocirc = {
  circle((0, 0), radius: 0.05, stroke: black)
  anchors((
    north: (0, 0.05),
    south: (0, -0.05),
    east: (0.05, 0),
    west: (-0.05, 0),
  ))
}

/// Connected terminal
/// type: node
#let circ = {
  fill(black)
  ocirc
}

/// Diamond-square terminal
/// type: node
#let diamondpole = {
  fill(black)
  anchors((
    north: (0, 0.05),
    south: (0, -0.05),
    east: (0.05, 0),
    west: (-0.05, 0),
  ))
  line(
    "north",
    "east",
    "south",
    "west",
    close: true,
  )
}

/// Square-shape terminal
/// type: node
#let squarepole = {
  fill(black)
  rect(
    (-0.05, -0.05),
    (0.05, 0.05),
  )
  anchors((
    north: (0, 0.05),
    south: (0, -0.05),
    east: (0.05, 0),
    west: (-0.05, 0),
  ))
}

/// Amplifiers

/// Operational amplifier
#let op-amp = {
  line(
    (0.5, 0),
    (-0.5, -.5),
    (-0.5, .5),
    close: true,
  )



  anchors((
    north: (0, 1),
    south: (0, -1),
    bout: (0.5, 0),
    east: (1, 0),
    west: (-1, 0),
  ))
}

#let op-not = {
  op-amp
  parts.not-circle
}

/// Logic gates

/// AND gate
/// type: node, fillable
#let n-and-gate(n) = {
  parts.n-and-gate-body(n)
  parts.n-logic-gate-legs(n)
}
#let and-gate = {
  parts.and-gate-body
  parts.logic-gate-legs
}

/// NAND gate
/// type: node, fillable
#let n-nand-gate(n) = {
  parts.n-and-gate-body(n)
  parts.not-circle
  // circle((rel: (0.1, 0), to: "bout"), radius: 0.1)
  // anchor("bout", (rel: (0.1, 0)))
  parts.logic-gate-legs
}
#let nand-gate = {
  parts.and-gate-body
  parts.not-circle
  // circle((rel: (0.1, 0), to: "bout"), radius: 0.1)
  // anchor("bout", (rel: (0.1, 0)))
  parts.logic-gate-legs
}

/// OR gate
/// type: node, fillable
#let n-or-gate(n) = {
  parts.n-or-gate-body(n)
  parts.n-logic-gate-legs(n)
}
#let or-gate = {
  parts.or-gate-body
  parts.logic-gate-legs
}

/// NOR gate
/// type: node, fillable
#let n-nor-gate(n) = {
  parts.n-or-gate-body(n)
  parts.not-circle
  parts.n-logic-gate-legs(n)
}
#let nor-gate = {
  parts.or-gate-body
  parts.not-circle
  parts.logic-gate-legs
}

/// XOR gate
/// type: node, fillable
#let n-xor-gate(n) = {
  parts.n-or-gate-body(n)
  parts.n-logic-gate-legs(n)
  parts.xor-bar
}
#let xor-gate = {
  parts.or-gate-body
  parts.logic-gate-legs
  parts.xor-bar
}

/// XNOR gate
/// type: node, fillable
#let n-xnor-gate(n) = {
  parts.n-or-gate-body(n)
  parts.not-circle
  parts.n-logic-gate-legs(n)
  parts.xor-bar
}
#let xnor-gate = {
  parts.or-gate-body
  parts.not-circle
  parts.logic-gate-legs
  parts.xor-bar
}

#let path = (
  // Resistive bipoles
  "short": short,
  "R": R,

  // Sources and generators
  "isourceAM": isourceAM,
)

#let node = (
  // Arrows
  "currarrow": currarrow,

  //Terminal Shapes
  "circ": circ,
  "ocirc": ocirc,
  "diamondpole": diamondpole,
  "squarepole": squarepole,

  // Amplifiers
  "op amp": op-amp,
  "op not": op-not,

  // Logic gates
) + range(
  2,
  5,
).map(i => {
  if i == 2 {
    i = ""
    (
      i + "and gate": and-gate,
      i + "nand gate": nand-gate,
      i + "or gate": or-gate,
      i + "nor gate": nor-gate,
      i + "xor gate": xor-gate,
      i + "xnor gate": xnor-gate,
    )
  } else {
    let si = str(i)
    (
      si + "and gate": n-and-gate(i),
      si + "nand gate": n-nand-gate(i),
      si + "or gate": n-or-gate(i),
      si + "nor gate": n-nor-gate(i),
      si + "xor gate": n-xor-gate(i),
      si + "xnor gate": n-xnor-gate(i),
    )
  }
}).fold(
  (:),
  (a, b) => a + b,
)
