extends Node2D

var layout = {}
var jsonfile
var pickup
var enemy1
var enemy2
var enemy3
var timer = 0
var currentPointer = 0
var canTrigger = true

func _ready():
	var file = File.new()
	file.open(jsonfile, file.READ)
	layout.parse_json(file.get_as_text())
	file.close()
	set_process(true)

func _process(delta):
	timer += delta
	var triggering = true
	while triggering and canTrigger:
		if layout["Layout"][currentPointer]["time"] <= timer:
			chooseSpawn(currentPointer)
			currentPointer += 1
			if currentPointer >= layout["Layout"].size():
				canTrigger = false
				break
		else:
			triggering = false

func chooseSpawn(pointer):
	var type = layout["Layout"][pointer]["event"]
	var options = layout["Layout"][pointer]
	var spawn 
	if type == 1: 
		spawn = pickup
	elif type == 2:
		spawn = enemy1
	elif type == 3:
		spawn = enemy2
	elif type == 4:
		spawn = enemy3
	var s = spawn.instance()
	s.options = options
	add_child(s)
