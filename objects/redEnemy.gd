extends Node2D

var name = "redEnemy"
var speed = 200
var yStart
var ySpeed = 100
var yLimit = 100
var screensize
var size
var options = {}
var shot = load("res://objects/EnemyShot.tscn")
var shotlayer 

func _ready():
	set_pos(Vector2(get_viewport_rect().size.x + 10, options["yaxis"]))
	yStart = options["yaxis"]
	screensize = get_viewport_rect().size
	if yStart > screensize.height/2:
		ySpeed *= -1
	size = get_node("Sprite").get_region_rect().size
	
	shotlayer = get_node("/root/Level1/Layer2/")
	shotlayer.print_tree()
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

func _on_Timer_timeout():
	var s = shot.instance()
	s.set_global_pos(get_global_pos())
	s.speed += speed
	shotlayer.add_child(s)