#import "@preview/cetz:0.4.1": canvas, draw
#import "../hestia/theme.typ": palette
#import "../slides_002/diagrams.typ": node, arrow, label

#let roadmap() = {
  for (x, title, detail) in ((0, [Input and output], [Read · transform · write]),
    (12, [Threads], [Run tasks concurrently]), (24, [Synchronization], [Protect shared state])) {
    node(x, 2, strong(title), width: 11,
      fill: if x == 0 { palette.surface } else { palette.green.lighten(85%) })
    label((x, .2), detail)
    label((x, 3.6), if x == 0 { [Previously] } else { [Today] })
    if x < 24 { arrow((x + 5.5, 2), (x + 6.5, 2)) }
  }
}

#let goals() = {
  for (y, action, tool, result) in ((6, [Create tasks], [Thread + Runnable], [Concurrent execution]),
    (3, [Coordinate tasks], [sleep() + join()], [Wait at the right time]),
    (0, [Protect shared state], [synchronized], [Mutual exclusion])) {
    node(0, y, action, width: 11)
    node(14, y, tool, width: 12)
    node(28, y, result, width: 12)
    arrow((5.5, y), (8, y))
    arrow((20, y), (22, y))
  }
}

#let cooking-serial() = {
  let steps = (
    [Heat burner], [Gather ingredients], [Gather tools], [Mix eggs],
    [Pan on burner], [Fry bacon], [Fry eggs], [Serve eggs],
    [Pudding ingredients], [Mix pudding], [Cook pudding], [Serve pudding],
  )
  for (i, body) in steps.enumerate() {
    let row = calc.floor(i / 4)
    let col = if row == 1 { 3 - calc.rem(i, 4) } else { calc.rem(i, 4) }
    let x = col * 10
    let y = 6 - row * 3
    node(x, y, body, width: 9)
    if calc.rem(i, 4) < 3 {
      let dir = if row == 1 { -1 } else { 1 }
      arrow((x + dir * 4.5, y), (x + dir * 5.5, y))
    } else if i < 11 { arrow((x, y - .5), (x, y - 2.5)) }
  }
  label((15, -2), [One cook · one task at a time])
}

#let cooking-parallel() = {
  // Arrows are dependencies, not durations; the burner imposes an extra order.
  for (x, title) in ((0, [Heat burner]), (11, [Eggs + bacon]),
    (22, [Gather bowls]), (33, [Pudding ingredients])) {
    node(x, 9, title, width: 10)
  }
  node(0, 5, [Fry bacon in pan], width: 10)
  node(15, 5, [Mix eggs], width: 9)
  node(33, 5, [Mix pudding], width: 10)
  arrow((0, 8.5), (0, 5.5))
  arrow((11, 8.5), (11, 7), (2, 7), (2, 5.5))
  arrow((11, 7), (15, 7), (15, 5.5))
  arrow((22, 8.5), (22, 6.5), (17, 6.5), (17, 5.5))
  arrow((22, 6.5), (31, 6.5), (31, 5.5))
  arrow((33, 8.5), (33, 5.5))
  node(8, 1, [Fry eggs], width: 10, fill: palette.yellow.lighten(90%))
  node(33, 1, [Cook pudding], width: 10, fill: palette.yellow.lighten(90%))
  arrow((0, 4.5), (0, 3), (6, 3), (6, 1.5))
  arrow((15, 4.5), (15, 3), (10, 3), (10, 1.5))
  arrow((33, 4.5), (33, 1.5))
  arrow((13, 1), (28, 1), color: palette.yellow)
  label((20.5, 2), [Release burner], color: palette.yellow)
  for (x, title) in ((8, [Serve eggs]), (33, [Serve pudding])) {
    node(x, -2, title, width: 10)
    arrow((x, .5), (x, -1.5))
  }
}

#let constraints() = {
  for (y, a, b, detail) in ((7, [Mix eggs], [Fry eggs], [Dependency: wait for a result]),
    (3, [Fry eggs], [Cook pudding], [Resource conflict: one burner]),
    (-1, [Cook A], [Cook B], [Communication: hand over ingredients])) {
    node(0, y, a, width: 9)
    node(13, y, b, width: 9)
    arrow((4.5, y), (8.5, y))
    label((6.5, y - 1.5), detail)
  }
}

#let memory() = {
  draw.rect((-6, -2), (28, 9), radius: .15, fill: none)
  label((11, 8), [*One Java process*])
  for (x, title, bottom) in ((1, [Main thread], [main()]), (21, [Worker thread], [run()])) {
    node(x, 5, title, width: 11)
    node(x, 2.8, [Own call stack\ Local variables · #bottom], width: 12, height: 2.2)
    arrow((x, 1.7), (x, 0), (if x == 1 { 4 } else { 18 }, 0))
  }
  node(11, 0, [Shared heap\ Objects + their fields], width: 14, height: 2)
}

#let jvm-threads() = {
  node(0, 4, [JVM starts], width: 8)
  for (y, title, detail) in ((7, [Main thread → main()], [Application code]),
    (1, [GC / runtime threads], [Reclaim unreachable objects])) {
    node(16, y, title, width: 15)
    label((16, y - 1.5), detail)
    arrow((4, 4), (6, 4), (6, y), (8.5, y))
  }
  label((11, -2), [Normal JVM shutdown: no live non-daemon threads remain])
}

#let scheduling() = {
  label((-5, 5), [One core])
  for (i, name) in ([A], [B], [A], [B], [A], [B]).enumerate() {
    node(i * 4, 5, name, width: 4,
      fill: if calc.even(i) { palette.green.lighten(85%) } else { palette.yellow.lighten(90%) })
  }
  label((10, 3.4), [Time slicing: concurrent, not simultaneous])
  for (y, title, name, fill) in ((0, [Core 1], [A], palette.green.lighten(85%)),
    (-2, [Core 2], [B], palette.yellow.lighten(90%))) {
    label((-5, y), title)
    node(10, y, name, width: 24, fill: fill)
  }
  arrow((-2, -4), (22, -4))
  label((10, -5), [Time → · on two cores, A and B can run in parallel])
}

#let thread-api() = {
  node(0, 5, [start()], width: 8)
  node(17, 5, [Starts a new execution thread], width: 20)
  arrow((4, 5), (7, 5))
  node(0, 1, [run()], width: 8)
  node(17, 1, [Contains the work], width: 20)
  arrow((4, 1), (7, 1))
  label((10, -1.5), [Calling run() directly is an ordinary call on the current thread])
}

#let fork() = {
  label((-6, 5), [main])
  label((-6, 0), [worker])
  node(0, 5, [new Thread()], width: 8)
  node(11, 5, [start()], width: 7)
  node(25, 5, [Continue main()], width: 12)
  arrow((4, 5), (7.5, 5))
  arrow((14.5, 5), (19, 5))
  node(18, 0, [run()], width: 8)
  node(31, 0, [Terminates], width: 10)
  arrow((11, 4.5), (11, 0), (14, 0))
  arrow((22, 0), (26, 0))
  label((7, -2), [Object creation ≠ thread start · a thread can be started only once])
}

#let class-box(x, y, title, methods) = {
  node(x, y, [], width: 12, height: 3)
  label((x, y + .85), strong(title))
  draw.line((x - 6, y + .2), (x + 6, y + .2))
  label((x, y - .65), methods)
}

#let inheritance() = {
  class-box(0, 6, [Thread], [start(): void · run(): void])
  class-box(0, 0, [PrintThread], [run(): void])
  draw.line((0, 1.5), (0, 4.5), mark: (end: "triangle"))
  label((10, 3), [extends Thread])
  label((15, 0), [Override run()\ Inherit start()])
}

#let runnable() = {
  class-box(0, 7, [«interface» Runnable], [run(): void])
  class-box(0, 0, [PrintRunnable], [run(): void])
  class-box(22, 0, [Thread], [start(): void · run(): void])
  draw.line((0, 1.5), (0, 5.5), stroke: (dash: "dashed"), mark: (end: "triangle"))
  label((5, 3.5), [implements])
  arrow((16, 0), (6, 0))
  label((11, -1.6), [Delegates to task.run()])
  label((0, -3.4), [What to execute])
  label((22, -3.4), [Execution mechanism])
  label((22, 5), [new Thread(task)])
}

#let counter-output() = {
  label((2, 7), [main])
  label((19, 7), [worker])
  for (y, a, b) in ((5, [0 · 1 · 2], [0 · 1]), (2, [3 · … · 9], [2 · 3 · 4]),
    (-1, [Exiting main()], [5 · … · 9]), (-4, [Finished], [Exiting run()])) {
    node(2, y, a, width: 12)
    node(19, y, b, width: 12)
  }
  arrow((-6, 6), (-6, -4))
  label((-8, 1), [Time])
  label((10, -6), [One possible interleaving · each counter still runs from 0 to 9])
}

#let states() = {
  for (x, title, detail) in ((0, [NEW], [Object created]), (15, [RUNNABLE], [Ready or executing]),
    (31, [TERMINATED], [run() has ended])) {
    node(x, 6, title, width: 11)
    label((x, 7.6), detail)
  }
  arrow((5.5, 6), (9.5, 6))
  label((7.5, 5), [start()])
  arrow((20.5, 6), (25.5, 6))
  label((23, 5), [return / throw])
  for (x, title, cause, resume) in ((0, [BLOCKED], [Monitor busy], [Lock acquired]),
    (15, [WAITING], [join() / wait()], [Target ends / signal†]),
    (31, [TIMED_WAITING], [sleep() /\ timed join()], [Timeout / target ends])) {
    node(x, 0, title, width: 13)
    arrow((15, 5.5), (15, 3.5), (x - 3, 3.5), (x - 3, .5))
    label((x, 2.3), cause)
    arrow((x + 3, .5), (x + 3, 4.2), (18, 4.2), (18, 5.5), dashed: true)
    label((x, -1.5), resume)
  }
  label((15, -3.5), [†wait() must reacquire the monitor; interruption also ends sleep / join / wait])
  label((15, -5), [A terminated thread cannot restart; its Java object may still exist])
}

#let scheduler() = {
  draw.rect((-6, -1), (28, 8), radius: .15, fill: none)
  label((11, 7), [*Java state: RUNNABLE*])
  node(0, 3, [Ready for CPU], width: 10)
  node(22, 3, [Executing on CPU], width: 11)
  arrow((0, 3.5), (0, 5), (22, 5), (22, 3.5))
  label((11, 5.8), [Scheduler selects])
  arrow((22, 2.5), (22, .5), (0, .5), (0, 2.5))
  label((11, 1.4), [Preemption / yield])
  label((11, -3), [No guaranteed order or fairness · setPriority() is only a hint])
}

#let sleep() = {
  node(0, 3, [RUNNABLE], width: 11)
  node(22, 3, [TIMED_WAITING], width: 13)
  arrow((0, 3.5), (0, 6), (22, 6), (22, 3.5))
  label((11, 7), [Current thread calls Thread.sleep(ms)])
  arrow((22, 2.5), (22, 0), (0, 0), (0, 2.5))
  label((11, -1), [Timeout or InterruptedException])
  label((11, -3), [Ready again ≠ immediately running · sleep() does not release monitors])
}

#let blink() = {
  node(0, 2, [Yellow], width: 9, height: 3, fill: rgb("#fff09c"))
  node(21, 2, [Light gray], width: 9, height: 3, fill: rgb("#d3d3d3"))
  arrow((0, 3.5), (0, 5), (21, 5), (21, 3.5))
  label((10.5, 6), [≈ 750 ms])
  arrow((21, .5), (21, -1), (0, -1), (0, .5))
  label((10.5, -2), [≈ 750 ms])
}

#let gui-threads() = {
  node(0, 5, [FlashThread], width: 11)
  node(15, 5, [Swing event queue], width: 12)
  node(31, 5, [Event dispatch thread], width: 13)
  arrow((5.5, 5), (9, 5))
  arrow((21, 5), (24.5, 5))
  label((15, 7), [invokeLater(...)])
  node(0, 0, [sleep(750)], width: 11)
  arrow((0, 4.5), (0, .5))
  arrow((-5.5, 0), (-8, 0), (-8, 5), (-5.5, 5))
  node(31, 0, [switchLight()], width: 13)
  arrow((31, 4.5), (31, .5))
  label((16, -2), [Worker waits · only the EDT changes Swing components])
}

#let join() = {
  label((-6, 5), [main])
  label((-6, 0), [worker])
  node(0, 5, [start()], width: 7)
  node(12, 5, [join() · WAITING], width: 12)
  node(28, 5, [Print result], width: 10)
  arrow((3.5, 5), (6, 5))
  arrow((18, 5), (23, 5))
  node(12, 0, [run()], width: 10)
  node(28, 0, [Terminates], width: 10)
  arrow((0, 4.5), (0, 0), (7, 0))
  arrow((17, 0), (23, 0))
  arrow((28, .5), (28, 4.5), dashed: true)
  label((14, -2), [join() waits for this worker · interruption throws InterruptedException])
}

#let join-variants() = {
  for (y, call, behavior) in ((6, [sleepy.join()], [Wait until sleepy terminates]),
    (3, [No join()], [Loop repeats after each 400 ms sleep]),
    (0, [sleepy.join(1500)], [Wait up to 1500 ms, then recheck isAlive()])) {
    node(0, y, call, width: 12)
    node(23, y, behavior, width: 29)
    arrow((6, y), (8.5, y))
  }
  label((13, -2), [A timed join may return while the worker is still alive])
}

#let lost-update() = {
  for (x, title) in ((0, [deposit(50)]), (16, [withdraw(50)]), (31, [Shared balance])) {
    label((x, 9), strong(title))
  }
  node(31, 7, [5000], width: 8)
  for (y, x, operation, balance) in ((5, 0, [Read 5000 → compute 5050], [5000]),
    (2, 16, [Read 5000 → compute 4950], [5000]),
    (-1, 0, [Write 5050], [5050]), (-4, 16, [Write 4950], [4950])) {
    node(x, y, operation, width: 15)
    node(31, y, balance, width: 8,
      fill: if y == -4 { palette.coral.lighten(90%) } else { palette.surface })
    if y >= 2 { arrow((27, y), (x + 7.5, y), dashed: true) }
    else { arrow((x + 7.5, y), (27, y), color: palette.coral) }
  }
  arrow((-10, 7), (-10, -4))
  label((-10, 9), [Time ↓])
  label((15, -6), [Expected: 5000 · actual: 4950 · the deposit is lost])
}

#let access() = {
  for (y, a, b, detail, fill) in ((6, [Read], [Read], [No conflicting writes], palette.green.lighten(85%)),
    (2, [Read], [Write], [Value / visibility may depend on order], palette.coral.lighten(90%)),
    (-2, [Write], [Write], [Updates can overwrite each other], palette.coral.lighten(90%))) {
    node(0, y, a, width: 6)
    node(14, y, [Shared field], width: 10, fill: fill)
    node(28, y, b, width: 6)
    arrow((3, y), (9, y))
    arrow((25, y), (19, y))
    label((14, y - 1.5), detail)
  }
  label((14, 8), [Two threads · same field · no synchronization])
}

#let monitor() = {
  node(0, 6, [Thread A · owns monitor], width: 15, fill: palette.green.lighten(85%))
  node(0, 0, [Thread B · BLOCKED], width: 15, fill: palette.coral.lighten(90%))
  draw.rect((14, -2), (33, 8), radius: .15, fill: none)
  label((23.5, 7), [*One Account object*])
  node(23.5, 4, [synchronized deposit()], width: 17)
  node(23.5, 0, [synchronized withdraw()], width: 17)
  arrow((7.5, 6), (11, 6), (11, 4), (15, 4))
  draw.line((7.5, 0), (12, 0), stroke: 1pt + palette.coral)
  draw.line((12, -1), (12, 1), stroke: 2pt + palette.coral)
  label((10, -3.5), [Same monitor for both methods · released on return or exception])
}

#let safe-update() = {
  node(0, 6, [Before: 5000], width: 10)
  node(19, 6, [deposit(50)\ Read 5000 · write 5050], width: 17, height: 2.4)
  node(19, 0, [withdraw(50)\ Read 5050 · write 5000], width: 17, height: 2.4)
  node(0, 0, [After: 5000], width: 10, fill: palette.green.lighten(85%))
  arrow((5, 6), (10.5, 6))
  arrow((19, 4.8), (19, 1.2))
  label((7, 3), [Release → next acquire])
  arrow((10.5, 0), (5, 0))
  label((11, -3), [One monitor · each read–check–write is protected])
  label((11, -4.5), [The opposite order also preserves the balance])
}

#let monitor-scope() = {
  node(0, 7, [A · owns monitor 1], width: 13, fill: palette.green.lighten(85%))
  node(0, 3, [B · waits for monitor 1], width: 13, fill: palette.coral.lighten(90%))
  node(24, 7, [Account 1\ Monitor 1], width: 13, height: 2.4)
  arrow((6.5, 7), (17.5, 7))
  draw.line((6.5, 3), (13, 3), (13, 6), (17.5, 6), stroke: 1pt + palette.coral)
  draw.line((12, 6), (14, 6), stroke: 2pt + palette.coral)
  label((24, 3), [Same instance → wait])
  node(0, -2, [C · owns monitor 2], width: 13, fill: palette.green.lighten(85%))
  node(24, -2, [Account 2\ Monitor 2], width: 13, height: 2.4)
  arrow((6.5, -2), (17.5, -2))
  label((12, -5), [Different instances → independent monitors])
}

#let diagrams = (
  roadmap: roadmap, goals: goals, cooking-serial: cooking-serial, cooking-parallel: cooking-parallel,
  constraints: constraints, memory: memory, jvm-threads: jvm-threads, scheduling: scheduling,
  thread-api: thread-api, fork: fork, inheritance: inheritance, runnable: runnable,
  counter-output: counter-output, states: states, scheduler: scheduler, sleep: sleep,
  blink: blink, gui-threads: gui-threads, join: join, join-variants: join-variants,
  lost-update: lost-update, access: access, monitor: monitor, safe-update: safe-update,
  monitor-scope: monitor-scope,
)

#let diagram(name, height: 250pt) = layout(size => {
  set text(size: 26pt, fill: palette.ink)
  set par(leading: .5em)
  let body = canvas({
    draw.set-style(stroke: .8pt + palette.muted)
    diagrams.at(name)()
  })
  let natural = measure(body)
  let factor = calc.min(size.width / natural.width, height / natural.height)
  assert(factor > 0, message: "No room for diagram: " + name)
  align(center, scale(x: factor * 100%, y: factor * 100%, reflow: true, body))
})
