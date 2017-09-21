extends Node2D

var redEnemy = load("res://objects/redEnemy.tscn")
var laserShip = load("res://objects/LaserEnemy.tscn")
var minTime = 0.5
var maxTime = 1
var timer = 0
var targetTime = 0

func _ready():
	targetTime = rand_range(minTime, maxTime)
	set_process(true)
	pass

func _process(delta):
	if (Input.is_action_pressed("ui_select")):
		spawnLaserShip()
	timer += delta
	if timer > targetTime:
		targetTime = rand_range(minTime, maxTime)
		timer = 0
		spawnEnemy()
		
func spawnEnemy():
	var e = redEnemy.instance()
	add_child(e)
	e.set_state(true)
	e.set_pos(Vector2(get_viewport_rect().size.x + 10, rand_range(0,get_viewport_rect().size.y)))
	
func spawnLaserShip():
	var e = laserShip.instance()
	add_child(e)
	e.set_pos(Vector2(get_viewport_rect().size.x + 10, 200))


