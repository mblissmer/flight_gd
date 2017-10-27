extends KinematicBody2D


var screenSize
var playerSize
const playerSpeed = 250
var rightConstraint = 800
var swirls = []
var swirlSpeed = 5
var swirlTopSpeed = 10
var swirlSpeedInc = 5
var pickupCounter = 0
var shieldOn = false
var shield
var hits

func _ready():
	hits = get_node()
	shield = get_node("Shield")
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
	
func pickup():
	pickupCounter+=1
	if pickupCounter <= swirls.size():
		swirls[pickupCounter-1].show()
#	if pickupCounter == swirls.size():
#		shieldOn = true
#		shield.show()
func hit():
	print("hit")
