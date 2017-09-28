extends Node2D

var name = "laserEnemy"
var stage = 1
var nextStage = 2
var speed = 75
var pauseTime = 4
var timer = 0
var xStop = 0
var yStop = 0
var options = {}
var offscreen
var laser
var goUp = false

func _ready():
	offscreen = get_viewport_rect().size.x + 100
	set_pos(Vector2(offscreen, options["yaxis"]))
	xStop = options["xstop"]
	yStop = options["ystop"]
	if options["yaxis"] > yStop:
		goUp = true
	laser = get_node("Laser")
	laser.timeLimit = pauseTime-1
	set_process(true)
	
func _process(delta):
	var pos = get_pos()
	if stage == 1:
		pos.x -= speed * delta
		if pos.x <= xStop:
			stage = 999
			nextStage = 2
			laser.fireLaser = true
	elif stage == 2: 

		if goUp:
			pos.y -= speed * delta
			if pos.y <= yStop:
				stage = 999
				nextStage = 3
				laser.fireLaser = false
		else:
			pos.y += speed * delta
			if pos.y >= yStop:
				stage = 999
				nextStage = 3
				laser.fireLaser = false
	elif stage == 3:
		pos.x += speed * delta
		if pos.x > offscreen:
			queue_free()
	else:
		timer += delta
		if timer >= pauseTime:
			stage = nextStage
			timer = 0
	set_pos(pos)

func clear():
	queue_free()