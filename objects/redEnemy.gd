extends Node2D

var active = false
var name = "redEnemy"
var speed = 200

func _ready():
	set_process(true)
	pass

func _process(delta):
		
	var pos = get_pos()
	pos.x -= speed * delta
	set_pos(pos)
	if pos.x < 50:
		cleared()
	
func cleared():
	queue_free()

func get_state():
	return active
	
func set_state(state):
	active = state