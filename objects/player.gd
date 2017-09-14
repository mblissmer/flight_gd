extends Area2D

var screenSize
var playerSize
const playerSpeed = 250
var rightConstraint = 800
var swirls = []
var swirlSpeed = 5
var swirlTopSpeed = 10
var swirlSpeedInc = 5
var pickupCounter = 0

func _ready():
	screenSize = get_viewport_rect().size
	playerSize = get_node("Sprite").get_region_rect().size
	swirls = [get_node("Swirl"),get_node("Swirl1"),get_node("Swirl2"),get_node("Swirl3")]
	for s in swirls:
		s.hide()
	set_process(true)

func _process(delta):
	var pos = get_pos()
	
	if (pos.x > playerSize.x / 4 and Input.is_action_pressed("ui_left")):
		pos.x -= playerSpeed * delta
	if (pos.x < rightConstraint and Input.is_action_pressed("ui_right")):
		pos.x += playerSpeed * delta
	
	if (pos.y > playerSize.y / 4 and Input.is_action_pressed("ui_up")):
		pos.y -= playerSpeed * delta
	if (pos.y < screenSize.height - playerSize.y / 4 and Input.is_action_pressed("ui_down")):
		pos.y += playerSpeed * delta
	
	set_pos(pos)
	
	if pickupCounter >= swirls.size() && swirlSpeed < swirlTopSpeed:
		swirlSpeed += swirlSpeedInc * delta
		
	
	for s in swirls:
		var srot = s.get_rot()
		srot += swirlSpeed * delta
		if srot > PI*2:
			srot -= PI*2
		s.set_rot(srot)
	
	var overlap = get_overlapping_areas()
	if overlap.size() > 0:
		for o in overlap:
			var obj = o.get_node(".")
			if obj.name == "pickup":
				obj.picked_up()
				pickupCounter+=1 #test
				if pickupCounter <= swirls.size():
					swirls[pickupCounter-1].show()
		