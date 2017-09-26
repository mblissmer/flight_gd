extends Area2D

#var active = false
var name = "pickup"
var speed = 200
var lowTurnSpeed = 5
var midTurnSpeed = 6
var highTurnSpeed = 7
var low
var mid
var high

func _ready():
	low = get_node("low")
	mid = get_node("mid")
	high = get_node("high")
	set_process(true)

func _process(delta):
	var pos = get_pos()
	pos.x -= speed * delta
	set_pos(pos)
	if pos.x <= -100:
		queue_free()
	
	var lrot = low.get_rot()
	var mrot = mid.get_rot()
	var hrot = high.get_rot()
	
	lrot += lowTurnSpeed * delta
	if lrot > PI*2:
		lrot -= PI*2
	low.set_rot(lrot)
	
	mrot += midTurnSpeed * delta
	if mrot > PI*2:
		mrot -= PI*2
	mid.set_rot(mrot)
	
	hrot += highTurnSpeed * delta
	if hrot > PI*2:
		hrot -= PI*2
	high.set_rot(hrot)
	
func picked_up():
	queue_free()

#func get_state():
#	return active
#	
#func set_state(state):
#	active = state