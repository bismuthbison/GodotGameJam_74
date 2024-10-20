extends StaticBody2D

@export var anime : AnimatedSprite2D
@export var collish : CollisionShape2D
@export var open_sound : AudioStream

var active = false #should be set to false unless testing
func _ready() -> void:
	anime.play("idle")
	SignalBus.activate_exit.connect(_makeActive)
	self.hide()
	collish.set_deferred("disabled", true)
	
func _makeActive():
	active = true
	collish.disabled = false
	self.show()
	
	
func exitLevel() -> bool:
	if active == true: 
		SignalBus.load_next_scene.emit()
		return true
	else: 
		return false
