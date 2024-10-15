extends StaticBody2D

enum PROBLEM_NAME {PIPE, RAT, SPIDER, CRACK}
enum {SOLVED, UNSOLVED}

var state = SOLVED

@export var problemType : PROBLEM_NAME
@export var solution : GameItem

func attemptSolution(item : GameItem):
	if item == null:
		SignalBus.update_talkbox.emit("I am holding nothing")
		return
	match problemType: 
		PROBLEM_NAME.PIPE: 
			SignalBus.update_talkbox.emit("This is a pipe")
			if solution.name == item.name: 
				SignalBus.update_talkbox.emit("Fixed!")
				$Sprite2D.frame = 0
				
		_: 
			SignalBus.update_talkbox.emit("What problem?")
