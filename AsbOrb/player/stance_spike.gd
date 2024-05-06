extends Marker2D
class_name StanceSpike

@onready var sprite = $Sprite
var extended : bool = false

func _physics_process(delta):
	jitter(delta)

func jitter(delta):
	if not extended:
		sprite.position.x = move_toward(sprite.position.x, 480, delta * 3600)
		sprite.scale.x = move_toward(sprite.scale.x, 1.5, delta * 3600)
	
	if extended: 
		sprite.position.x = move_toward(sprite.position.x, 320, delta * 3600)
		sprite.scale.x = move_toward(sprite.scale.x, 1, delta * 3600)
	
	if sprite.position.x == 480 and sprite.scale.x == 1.5:
		extended = true
		
	elif sprite.position.x == 320 and sprite.scale.x == 1:
		extended = false
