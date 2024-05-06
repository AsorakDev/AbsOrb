extends State
class_name PlayerLaunch

@onready var player = $"../.."

func stateEnter():
	launch()

func stateUpdate(_delta):
	transitions()

func stateExit():
	pass

func launch():
	player.velocity = player.get_local_mouse_position().normalized() * player.launch_strength

func transitions():
	state_transition.emit(self, "Idle")
