extends Node2D

var hearts = []

func _ready():
	hearts.append(get_node("heart1"))
	hearts.append(get_node("heart2"))
	hearts.append(get_node("heart3"))
	var heartWidth = hearts[0].get_node("heartEmpty").get_texture().get_size().x
	print(heartWidth)
	var xpos = 0
	for heart in hearts:
		var newpos = Vector2(xpos,0)
		heart.set_pos(newpos)
		print(newpos)
		xpos += heartWidth
