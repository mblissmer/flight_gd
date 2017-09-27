extends Node2D

var name = "laserEnemy"
var stage = 1
var nextStage = 2
var laserFiring = false
var laserTimer = 0
var speed = 100
var pauseTime = 3
var timer = 0

func _ready():
	pass
	set_process(true)
	
func _process(delta):
	var pos = get_pos()
	if stage == 1:
		pos.x -= speed * delta
		if pos.x <= 800:
			stage = 999
			nextStage = 2
	elif stage == 2: 
		pos.y += speed * delta
		if pos.y >= 600:
			stage = 999
			nextStage = 3
	elif stage == 3:
		pos.x += speed * delta
		if pos.x > get_viewport_rect().size.x + 100:
			queue_free()
	else:
		timer += delta
		if timer >= pauseTime:
			stage = nextStage
			if nextStage == 2:
				laserFiring = true
			timer = 0
	set_pos(pos)
	
	if laserFiring:
		
		pass
	
	
func fireLaser(isFiring):
	print("FIRE!")
	laserFiring = isFiring

func clear():
	queue_free()