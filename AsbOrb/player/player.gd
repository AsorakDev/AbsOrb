extends CharacterBody2D
class_name Player


@onready var label = $HUD/Label
@onready var fsm = $FSM

@onready var roll_timer = $RollTimer
@onready var ray_cast = $RayCast
@onready var sprite = $Sprite


var gravity : float = 1600
var max_gravity : float = 600
var max_speed : float = 600
var launch_strength : float = -1000
var friction_airborne : float = 400
var friction_grounded : float = 1200

var ignore_gravity : bool = false
var enemy_detected : bool = false
var exceed_max_velocity : bool = false

func _ready():
	pass

func _process(_delta):
	pass

func _physics_process(delta):
	aim()
	apply_gravity(delta)
	apply_friction(delta)
	reset_rotation()
	move_and_slide()
	debug()

func aim():
	sprite.look_at(get_global_mouse_position())
	ray_cast.target_position = get_local_mouse_position()
	if ray_cast.is_colliding():
		if ray_cast.get_collider().get_parent() as Enemy:
			enemy_detected = true
		else : enemy_detected = false
	else: enemy_detected = false

func apply_gravity(delta):
	if not ignore_gravity: velocity.y = move_toward(velocity.y, max_gravity, delta * 1600)
	
func apply_friction(delta):
	if not exceed_max_velocity:
		if not is_on_floor():
			if velocity.x > max_speed: velocity.x = move_toward(velocity.x, max_speed, delta * friction_airborne)
			elif velocity.x < -max_speed : velocity.x = move_toward(velocity.x, -max_speed, delta * friction_airborne)
			
		else: velocity.x = move_toward(velocity.x, 0, delta * friction_grounded)

func reset_rotation():
	if sprite.rotation >= 6.2 or sprite.rotation <= -6.2:
		sprite.rotation = 0
		if is_on_floor():
			roll_timer.start()

func debug():
	label.text = "State: " + fsm.current_state.name \
	+ "\n Vel.Y: " + str(velocity.y) + "\n Vel.X: " + str(velocity.x) \
	+ "\n Rot: " + str(sprite.rotation) + "\n Enemy detected:"+ str(enemy_detected)
