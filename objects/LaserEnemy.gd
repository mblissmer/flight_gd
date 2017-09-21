extends Node2D

var name = "laserEnemy"

func ready():
	get_node("AnimationPlayer").play("movement")	

func move():
	get_node("AnimationPlayer").play("movement")

func fireLaser():
	print("FIRE!")

func clear():
	queue_free()