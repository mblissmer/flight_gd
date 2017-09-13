extends Node2D

var screenSize
var bgFarSize
var bgNearSize
var farMoveSpeed = 1
var nearMoveSpeed = 2

func _ready():
	screenSize = get_viewport_rect().size
	bgFarSize = get_node("bgFar").get_region_rect().size
	bgNearSize = bgFarSize * get_node("bgNear").get_scale().x
	get_node("bgFar").set_pos(Vector2(0, screenSize.height-bgFarSize.height))
	get_node("bgFar1").set_pos(Vector2(bgFarSize.width, screenSize.height-bgFarSize.height))
	get_node("bgNear").set_pos(Vector2(0, screenSize.height-bgNearSize.height))
	get_node("bgNear1").set_pos(Vector2(bgNearSize.width, screenSize.height-bgNearSize.height))
	set_process(true)

func _process(delta):
	var bgFarPos = get_node("bgFar").get_pos()
	var bgFarPos1 = get_node("bgFar1").get_pos()
	var bgNearPos = get_node("bgNear").get_pos()
	var bgNearPos1 = get_node("bgNear1").get_pos()
	bgFarPos.x -= farMoveSpeed
	bgFarPos1.x -= farMoveSpeed
	if bgFarPos.x + bgFarSize.width < 0:
		bgFarPos.x = bgFarPos1.x + bgFarSize.width
	if bgFarPos1.x + bgFarSize.width < 0:
		bgFarPos1.x = bgFarPos.x + bgFarSize.width
	
	bgNearPos.x -= nearMoveSpeed
	bgNearPos1.x -= nearMoveSpeed
	if bgNearPos.x + bgNearSize.width < 0:
		bgNearPos.x = bgNearPos1.x + bgNearSize.width
	if bgNearPos1.x + bgNearSize.width < 0:
		bgNearPos1.x = bgNearPos.x + bgNearSize.width
	
	get_node("bgFar").set_pos(bgFarPos)
	get_node("bgFar1").set_pos(bgFarPos1)
	get_node("bgNear").set_pos(bgNearPos)
	get_node("bgNear1").set_pos(bgNearPos1)