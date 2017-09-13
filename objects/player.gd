extends Area2D

var screenSize
var playerSize
const playerSpeed = 250
var rightConstraint = 800

func _ready():
	screenSize = get_viewport_rect().size
	playerSize = get_node("Sprite").get_region_rect().size
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
	var overlap = get_overlapping_areas()
	if overlap.size() > 0:
		for o in overlap:
			o.get_node(".").picked_up()
		