extends State
class_name PlayerIdle

@onready var player = $"../.."

func stateEnter():
	pass

func stateUpdate(_delta):
	transitions()

func stateExit():
	pass

func transitions():
	if Input.is_action_just_pressed("LM"):
		state_transition.emit(self, "Launch")
	
	elif Input.is_action_just_pressed("RM"):
		state_transition.emit(self, "Stance")
	
	elif player.is_on_floor() and not player.roll_timer.is_stopped():
		state_transition.emit(self, "Roll")
