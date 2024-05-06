extends State
class_name PlayerGrab

@onready var player = $"../.."
@onready var ARM : PackedScene = preload("res://player/arm.tscn")

func stateEnter():
	player.ignore_gravity = true
	player.velocity = Vector2.ZERO
	spawn_arm()

func stateUpdate(_delta):
	transitions()

func stateExit():
	player.ignore_gravity = false

func spawn_arm():
	var arm_instance = ARM.instantiate()
	arm_instance.rotation = player.sprite.rotation
	arm_instance.position = player.position
	$"../../LimbManager".add_child(arm_instance)

func transitions():
	if not Input.is_action_pressed("LM") and not Input.is_action_pressed("RM"):
		state_transition.emit(self, "Idle")
	
	if not Input.is_action_pressed("LM"):
		state_transition.emit(self, "Stance")
		
	if Info.pull_point != Vector2.ZERO and Input.is_action_pressed("LM") and Info.player_to_destination:
		state_transition.emit(self, "Pull")
