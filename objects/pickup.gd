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
#	pickups[i].set_pos(Vector2(currentPos.x - speed, currentPos.y))
#	if pickups[i].get_pos().x < -100:
#		pickups[i].queue_free()
#		pickups.remove(pickups[i])
func picked_up():
	queue_free()

func get_state():
	return active
	
func set_state(state):
	active = state