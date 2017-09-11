extends Node2D

var size
var frame = 0
var totalFrames = 2
var speed = 0.5
var timer = 0
var frames = [Vector2(560,0),Vector2(448,0), Vector2(0,0), Vector2(448,0)]

func _ready():
	set_process(true)
	pass

func _process(delta):
	timer += delta
	if timer > speed:
		timer = 0
		frame = frame + 1
		if frame > totalFrames:
			frame = 0
		var newframe = Rect2(frames[frame], Vector2(108,108))
		get_node("Sprite").set_region_rect(newframe)
	