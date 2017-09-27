extends Node2D

func _ready():
	var level1 = load("res://objects/Creator.tscn")
	var l = level1.instance()
	l.jsonfile = "res://levels/level1.json"
	l.pickup = load("res://objects/pickup.tscn")
	l.enemy1 = load("res://objects/redEnemy.tscn")
	l.enemy2 = load("res://objects/Bomb.tscn")
	l.enemy3 = load("res://objects/LaserEnemy.tscn")
	add_child(l)
	set_process(true)
	
func _process(delta):
	if (Input.is_action_pressed("ui_cancel")):
		get_tree().quit()
	if (Input.is_action_pressed("pause")):
	    get_node("Popup").show()
	    get_tree().set_pause(true)


func _on_Button_released():
	pass

func _on_Button_pressed():
    get_node("Popup").hide()
    get_tree().set_pause(false)
