extends Node2D

var name = "redEnemy"
var speed = 200
var yStart
var ySpeed = 100
var yLimit = 100
var screensize
var size

func _ready():
	var pos = get_pos()
	yStart = pos.y
	screensize = get_viewport_rect().size
	if yStart > screensize.height/2:
		ySpeed *= -1
	size = get_node("Sprite").get_region_rect().size
	set_process(true)

func _process(delta):
		
	var pos = get_pos()
	pos.x -= speed * delta
	pos.y += ySpeed * delta
	if pos.y < yStart - yLimit or pos.y > yStart + yLimit:
		ySpeed *= -1
	set_pos(pos)
	if pos.x < -size.x *2:
		queue_free()
	
func cleared():
	queue_free()