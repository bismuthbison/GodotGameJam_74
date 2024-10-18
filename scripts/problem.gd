extends StaticBody2D

enum {SOLVED, UNSOLVED}

var state = UNSOLVED

@export var solution : GameItem
@export var description : Dialogue
@export var image : Texture2D
@export var audio : AudioStream

func _ready():
	self.call_deferred("_post_ready")
	if image != null:
		$Sprite2D.texture = image
	
	
func _post_ready(): #so after all has loaded we want the game engine to know all the problems that are there
	SignalBus.ping_a_problem.emit()
	

func attemptSolution(item : GameItem):
	if item == null:
		SignalBus.update_talkbox.emit(description.get_next_line_text())
		return
	if state == SOLVED: 
		SignalBus.update_talkbox.emit("I have already fixed this")
		return
	if solution.name == item.name: 
		problemGotSolved()
	else:
		SignalBus.update_talkbox.emit(description.get_next_line_text())
	return
func problemGotSolved():
	state = SOLVED
	$Sprite2D.frame = 0
	SignalBus.problem_solved.emit()
	if audio != null:
		SignalBus.audio_trigger.emit(audio)
