extends Node2D
class_name PlayerSpike

@onready var cooldown = $Cooldown
@onready var hit_area = $HitArea
@onready var hit_box = $HitArea/HitBox
@onready var sprite = $Sprite
var hit_end : bool = false
var hits : int = 0

func _physics_process(delta):
	pull_out(delta)
	pull_in(delta)
	
	if sprite.position.x <= 0:
		hit_end = false
	
	if abs(hit_area.position.x) > abs(get_local_mouse_position().x) \
	or abs(hit_area.position.y) > abs(get_local_mouse_position().y):
		hit_end = true

func pull_out(delta):
	if not hit_end and cooldown.is_stopped():
		hit_box.disabled = false
		sprite.scale.x += 1 * delta * 10
		sprite.position.x += 1  * 320 * delta * 10
		hit_area.position = sprite.position * 2

func pull_in(delta):
	if hit_end and sprite.position.x > 0:
		hit_box.disabled = true
		sprite.scale.x -= 1 * delta * 10
		sprite.position.x -= 1  * 320 * delta * 10
		hit_area.position = sprite.position * 2

func _on_hit_area_area_entered(_area):
	cooldown.start()
	hit_end = true
	hits += 1
	print(str(hits))
