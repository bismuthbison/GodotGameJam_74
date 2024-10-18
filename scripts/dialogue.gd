class_name Dialogue
extends Resource

#Internal Variables
var _current_line : int = 0

@export var dialogue_text : Array[String] = ["Set me"]

func get_description() -> String: #The first line will always be description
	return dialogue_text[0]

func get_next_line_text( progress : bool = true # the dialogue will progress
						) -> String:
	if _current_line >= dialogue_text.size():
		return dialogue_text.back()
	var line = dialogue_text[_current_line]
	if progress == true:
		_current_line += 1 
	return line

func reset_progress():
	_current_line = 0
