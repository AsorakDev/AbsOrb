extends State
class_name PlayerStance

@onready var player = $"../.."
@onready var SPIKE : PackedScene = preload("res://player/stance_spike.tscn")
var spike_instance

func stateEnter():
	spawn_spike()
	player.velocity = Vector2.ZERO
	player.ignore_gravity = true

func stateUpdate(_delta):
	update_spike()
	transitions()

func stateExit():
	player.ignore_gravity = false 
	player.velocity = Vector2.ZERO
	$"../../LimbManager".remove_child(spike_instance)
	
func spawn_spike():
	spike_instance = SPIKE.instantiate()
	spike_instance.position = player.global_position
	spike_instance.rotation = player.sprite.rotation
	$"../../LimbManager".add_child(spike_instance)

func update_spike():
	spike_instance.position = player.global_position
	spike_instance.rotation = player.sprite.rotation

func transitions():
	if not Input.is_action_pressed("RM"):
		state_transition.emit(self, "Idle") 
	
	elif Input.is_action_pressed("LM"):
		state_transition.emit(self, "Grab")
		
	elif player.enemy_detected:
		state_transition.emit(self, "Attack")
