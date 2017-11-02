extends Node


func _ready():
	var file = File.new()
	file.open("res://levels/level1.json", file.READ)
	layout.parse_json(file.get_as_text())
	file.close()
