extends StaticBody2D

enum PROBLEM_NAME {PIPE, RAT, SPIDER, CRACK, HOLE, APPLIANCE}
enum {SOLVED, UNSOLVED}

var state = UNSOLVED

@export var problemType : PROBLEM_NAME
@export var solution : GameItem
@export var description : Dialogue

func _ready():
	self.call_deferred("_post_ready")
	
func _post_ready(): #so after all has loaded we want the game engine to know all the problems that are there
	SignalBus.ping_a_problem.emit()
	

func attemptSolution(item : GameItem):
	if item == null:
		SignalBus.update_talkbox.emit(description.get_next_line_text())
		return
	if state == SOLVED: 
		SignalBus.update_talkbox.emit("I have already fixed this")
		return
	match problemType: 
		PROBLEM_NAME.PIPE: 
			SignalBus.update_talkbox.emit("This is a pipe")
			if solution.name == item.name: 
				problemGotSolved()
		PROBLEM_NAME.RAT: #If the problem is a rat
			return
		PROBLEM_NAME.SPIDER: #if the problem is a spider
			return
		PROBLEM_NAME.CRACK: #if the problem is a crack in the wall
			return
		_: 
			SignalBus.update_talkbox.emit("I am not holding what I need")
	return
func problemGotSolved():
	state = SOLVED
	$Sprite2D.frame = 0
	SignalBus.update_talkbox.emit("Fixed!")
	SignalBus.problem_solved.emit()
