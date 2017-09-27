extends Area2D

var name = "enemyShot"
var speed = 150

func _ready():
	set_process(true)

func _process(delta):
	var pos = get_pos()
	pos.x -= speed * delta
	set_pos(pos)
	if pos.x <= -100:
		queue_free()
	
func hit():
	queue_free()