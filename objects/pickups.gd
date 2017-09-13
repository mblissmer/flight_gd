extends Node2D

var pickup = load("res://objects/pickup.tscn")
var minTime = 0.5
var maxTime = 1
var timer = 0
var targetTime = 0

func _ready():
	targetTime = rand_range(minTime, maxTime)
	set_process(true)
	pass
	
func _process(delta):
	timer += delta
	if timer > targetTime:
		targetTime = rand_range(minTime, maxTime)
		timer = 0
		spawnPickup()
		
func spawnPickup():
	var p = pickup.instance()
	add_child(p)
	p.set_state(true)
	p.set_pos(Vector2(get_viewport_rect().size.x + 10, rand_range(0,get_viewport_rect().size.y)))
	
