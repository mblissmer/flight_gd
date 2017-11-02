extends Node

func _ready():
	pass

func _on_newGame_released():
	Transition.fade_to("res://scenes/Level1.tscn")


func _on_quit_released():
	get_tree().quit()
