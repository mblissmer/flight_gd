extends Node2D

var activePickups = []
var pickup = load("res://objects/pickup.tscn")
var minTime = 1
var maxTime = 5
var timer = 0
var targetTime = 0

func _ready():
	targetTime = rand_range(minTime, maxTime)
	set_process(true)
	
func _process(delta):
	if (Input.is_action_pressed("ui_cancel")):
		get_tree().quit()
	timer += delta
	if timer > targetTime:
		targetTime = rand_range(minTime, maxTime)
		timer = 0
		var newpickup = pickup.instance()
		add_child(newpickup)
		activePickups.append(newpickup)
		newpickup.set_pos(Vector2(get_viewport_rect().size.x + 10, rand_range(0,get_viewport_rect().size.y)))
	for i  in range(activePickups.size()):
		var currentPos = activePickups[i].get_pos()
		activePickups[i].set_pos(Vector2(currentPos.x - 10, currentPos.y))