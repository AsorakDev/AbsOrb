extends State
class_name PlayerPull

@onready var player = $"../.."

func stateEnter():
	player.velocity = Vector2.ZERO
	player.ignore_gravity = true
	player.exceed_max_velocity = true
	player.velocity = (Info.pull_point - player.position).normalized() * 1800

func stateUpdate(_delta):
	transitions()

func stateExit():
	Info.pull_point = Vector2.ZERO
	player.ignore_gravity = false
	player.exceed_max_velocity = false

func transitions():
	if not Input.is_action_pressed("LM") or \
	player.velocity.x == 0 or player.velocity.y == 0:
		state_transition.emit(self, "Idle")
