extends State
class_name PlayerAttack

@onready var player = $"../.."
@onready var SPIKE : PackedScene = preload("res://player/spike.tscn")
var spike_instance

func stateEnter():
	spawn_spike()
	player.ignore_gravity = true

func stateUpdate(_delta):
	update_spike()
	transitions()

func stateExit():
	player.ignore_gravity = false
	$"../../LimbManager".remove_child(spike_instance)

func update_spike():
	spike_instance.rotation = player.sprite.rotation

func spawn_spike():
	spike_instance = SPIKE.instantiate()
	spike_instance.position = player.position
	$"../../LimbManager".add_child(spike_instance)

func transitions():
	if not player.enemy_detected or not Input.is_action_pressed("RM"):
		state_transition.emit(self, "Stance")
	
	if Input.is_action_pressed("LM"):
		state_transition.emit(self, "Grab")
