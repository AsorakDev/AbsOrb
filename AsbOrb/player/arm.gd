extends Node2D
class_name PlayerArm

@onready var sprite = $Sprite
@onready var hit_area = $HitArea

var accel : float = 3
var released : bool = false
var retract_fix : int = 1

func _ready():
	pass 

func _process(_delta):
	update_input()
	
func _physics_process(delta): 
	extend(delta)
	retract(delta)
	delete()
	
func update_input():
	if not Input.is_action_pressed("LM"):
		released = true
		
	if released:
		$HitArea/HitBox.disabled = true
		accel = 6

func extend(delta):
	if not released:
		sprite.scale.x += 16 * accel * delta 
		sprite.position.x += 16 * accel * 64 * delta
		hit_area.position.x = sprite.position.x * 2
		
		if accel >= 1:
			accel -= 0.05
		else: accel = 1
		
		if sprite.scale.y >= 0.01:
			sprite.scale.y -= 0.01
		else: sprite.scale.y = -0.01
		
func retract(delta):
	if released:
		sprite.scale.x -= 12 * accel * delta
		sprite.position.x -= 14 * accel * 64 / retract_fix * delta
		hit_area.position.x = sprite.position.x * 2
		
		if accel >= 1:
			accel -= 1
		else: accel = 1

func delete():
	if sprite.scale.x <= 0:
		queue_free()

func _on_hit_area_body_entered(body):
	if body as StaticBody2D:
		Info.player_to_destination = true
		
	else: Info.player_to_destination = false
	
	released = true
	Info.pull_point = hit_area.global_position
	if Info.player_to_destination:
		retract_fix = 2

func _on_hit_area_area_entered(_area):
	released = true

