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