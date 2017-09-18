extends Area2D

var active = false
var name = "pickup"
var speed = 200

func _ready():
	set_process(true)
	pass

func _process(delta):
	var pos = get_pos()
	pos.x -= speed * delta
	set_pos(pos)
	
func picked_up():
	queue_free()

func get_state():
	return active
	
func set_state(state):
	active = state