extends Node2D

var screenSize
var playerSize
const playerSpeed = 250

func _ready():
    screenSize = get_viewport_rect().size
    playerSize = get_node("Sprite").get_region_rect().size
    set_process(true)

func _process(delta):
	var pos = get_node(".").get_pos()
	if (pos.x > playerSize.x / 4 and Input.is_action_pressed("ui_left")):
		pos.x -= playerSpeed * delta
	if (pos.x < 200 and Input.is_action_pressed("ui_right")):
		pos.x += playerSpeed * delta
#	pos.x += 10
	if (pos.y > playerSize.y / 4 and Input.is_action_pressed("ui_up")):
		pos.y -= playerSpeed * delta
	if (pos.y < screenSize.height - playerSize.y / 4 and Input.is_action_pressed("ui_down")):
		pos.y += playerSpeed * delta
		
	get_node(".").set_pos(pos)