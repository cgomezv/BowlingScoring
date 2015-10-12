proc initialize_global_variables {} {
    global score
    global throws
    global current_throw
    global current_frame
    global isFirstThrow
    global ball
    global firstThrow
    global secondThrow
    set score [ expr {0}]
    set current_throw 0
    set current_frame 1
    set isFirstThrow true
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
    set frame [get_current_frame]
    set score [get_score_for_frame [expr {$frame - 1}]]
    return [ expr {$score}]
}

proc get_current_frame {} {
    global current_frame
    return [ expr {$current_frame}]
}

proc adjust_current_frame { pins} {
    global current_frame
    global isFirstThrow
    if { $isFirstThrow == true} {
	if { $pins == 10} {
	    incr current_frame
	} else {
	    set isFirstThrow false
	}
    } else {
	set isFirstThrow true
	incr current_frame
    }
    if {$current_frame > 11} {
	set current_frame 11
    }
}

proc add_throw { pins } {
    global score
    global throws
    global current_throw
    incr current_throw
    set throws($current_throw) $pins
    set score [expr {$score + $pins}]
    adjust_current_frame $pins
}

proc handle_second_throw {} {
    global throws
    global ball
    global firstThrow
    global secondThrow
    set score 0
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
    return [ expr {$score}]
}
proc get_score_for_frame { frame } {
    global throws
    global ball
    global firstThrow
    global secondThrow
    set score 0
    set ball 0
    for {set current_frame 0} {$current_frame < $frame} {incr current_frame} {
	incr ball
	set firstThrow [expr {$throws($ball)}]
	if {$firstThrow == 10} {
	    incr ball
	    set nextThrow [expr {$throws($ball)}]
	    incr ball
	    set nextNextThrow [expr {$throws($ball)}]
	    set score [expr {$score + $firstThrow + $nextThrow + $nextNextThrow}]
	    set ball [expr {$ball - 2}]
	} else {
	    set second_throw [handle_second_throw]
	    set score [expr {$score + $second_throw}]
	}
    }
    return [ expr {$score}]
}