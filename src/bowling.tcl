proc initialize_global_variables {} {
    global score
    global throws
    global current_throw
    set score [ expr {0}]
    set current_throw 0
    return
}

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
    global throws
    global current_throw
    incr current_throw
    set throws($current_throw) $pins
    set score [expr {$score + $pins}]
    return [ expr {$score}]
}

proc get_score_for_frame { frame } {
    global throws
    set score 0
    set ball 0
    for {set current_frame 0} {$current_frame < $frame} {incr current_frame} {
	incr ball
	set firstThrow [expr {$throws($ball)}]
	incr ball
	set secondThrow [expr {$throws($ball)}]
	set frameScore [expr {$firstThrow + $secondThrow}]
	if {$frameScore == 10} {
	    incr ball
	    set score [expr {$score + $frameScore + $throws($ball)}]
	    set ball [expr {$ball - 1}]
	} else {
	    set score [expr {$score + $frameScore}]
	}
    }
    return [ expr {$score}]
}