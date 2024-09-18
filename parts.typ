#import "@preview/cetz:0.2.2"
#import cetz.draw: merge-path, arc, line, circle

#import "utils.typ": anchors
#let and-gate-body = {
  merge-path(
    close: true,
    {
      arc((0, 0), start: -90deg, stop: 90deg, radius: 0.75, name: "curve", anchor: "origin")
      line(
        (0, 0.75),
        (-0.75, 0.75),
        (-0.75, -0.75),
      )
    },
  )
  anchors((
    "bin 1": (-0.75, 0.375),
    "in 1": (rel: (-0.75, 0)),
    "bin 2": (-0.75, -0.375),
    "in 2": (rel: (-0.75, 0)),
    "bout": (0.75, 0),
    "out": (rel: (0.75, 0)),
    "north": (0, 0.75),
    "south": (rel: (0, -1.5)),
    "east": "out",
    "west": ("in 1", "|-", "center"),
    "left": ("bin 1", "|-", "center"),
    "right": "bout",
  ))
}

#let or-gate-body = {
  merge-path(
    close: true,
    {
      arc((0.75, 0), start: -90deg, stop: -17deg, anchor: "end", name: "bcurve")
      arc((0.75, 0), start: 17deg, stop: 90deg, anchor: "start", name: "tcurve")
      line("tcurve.end", (-0.7, 0.7))
      arc((), start: 45deg, stop: -45deg, anchor: "start")
    },
  )

  // x coordinate of where the input legs touch the body of the gate
  let x = calc.cos(calc.asin(0.375)) - calc.cos(calc.asin(0.75)) - 0.75
  anchors((
    "bin 1": (x, 0.375),
    "in 1": (-1.5, 0.375),
    "bin 2": (x, -0.375),
    "in 2": (-1.5, -0.375),
    "bout": (0.75, 0),
    "out": (rel: (0.75, 0)),
    "north": (0, 0.75),
    "south": (rel: (0, -1.5)),
    "east": "out",
    "west": ("in 1", "|-", "center"),
    "left": ("bin 1", "|-", "center"),
    "right": "bout",
  ))
}

#let not-circle = {
  circle((rel: (0.15, 0), to: "bout"), radius: 0.15)
  anchors((
    "N-not": (),
    "body right": "bout",
    "bout": (rel: (0.3, 0)),
    "right": "bout",
  ))
}

#let xor-bar = {
  arc((-0.9, -0.75), start: -45deg, stop: 45deg)
  anchors((
    "ibin 1": "bin 1",
    "ibin 2": "bin 2",
    "bin 1": (rel: (-0.15, 0), to: "bin 1"),
    "bin 2": (rel: (-0.15, 0), to: "bin 2"),
    "body left": "left",
    "left": (rel: (-0.15, 0), to: "left"),
  ))
}

#let logic-gate-legs = for a in ("in 1", "in 2", "out") {
  line("b" + a, a)
}
