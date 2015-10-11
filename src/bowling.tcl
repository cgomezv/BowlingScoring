set score [ expr {0}]

proc sum {a b} {
    return [expr {$a + $b}]
}

proc square {x} {
    return [expr {$x * $x}]
}

proc sumar {a b c d} {
    set x [sum $a $b]
    set y [sum $c $d]
    return [expr {$x + $y}]
}

proc get_score {} {
    global score
    return [ expr {$score}]
}

proc add_throw { pins } {
    global score
    set score [expr {$score + $pins}]
    return [ expr {$score}]
}
