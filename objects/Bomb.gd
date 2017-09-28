extends Area2D

#var active = false
var name = "bomb"
var speed = 100
var options = {}

func _ready():
	set_pos(Vector2(get_viewport_rect().size.x + 10, options["yaxis"]))
	set_process(true)

func _process(delta):
	var pos = get_pos()
	pos.x -= speed * delta
	set_pos(pos)
	if pos.x <= -100:
		queue_free()
	
func picked_up():
	queue_free()
