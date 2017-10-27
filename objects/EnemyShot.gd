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
		
	var overlap = get_overlapping_bodies()
	if overlap.size() > 0:
		for o in overlap:
			var obj = o.get_node(".")
			if obj.get_name() == "Player":
				obj.hit()
				free()

	
func free():
	queue_free()
	
func hit():
	queue_free()