extends State
class_name PlayerRoll

@onready var player = $"../.."

func stateEnter():
	player.exceed_max_velocity = true

func stateUpdate(_delta):
	transitions()
	roll()

func stateExit():
	player.exceed_max_velocity = false

func roll():
	if player.sprite.rotation > 0:
		player.velocity.x += 1
		if player.velocity.x >= 250:
			player.velocity.x = 250
		
	elif player.sprite.rotation < 0:
		player.velocity.x -= 1
		if player.velocity.x <= -250:
			player.velocity.x = -250

func transitions():
	if Input.is_action_just_pressed("LM"):
		state_transition.emit(self, "Launch")
	
	if Input.is_action_pressed("RM"):
		state_transition.emit(self, "Stance")

func _on_roll_timer_timeout():
	state_transition.emit(self, "Idle")
