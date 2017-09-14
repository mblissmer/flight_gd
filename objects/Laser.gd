extends RayCast2D

var mid
var oldMouse
var originalSize

func _ready():
	mid = get_node("Mid")
	originalSize = mid.get_region_rect().size
	set_process(true)
	
func _process(delta):
	var mouse = get_viewport().get_mouse_pos()
	var pos = mid.get_pos()
	var size = mid.get_region_rect().size
	if oldMouse != mouse:
		mid.set_region_rect(Rect2(pos,originalSize))
		oldMouse = mouse
	mid.look_at(mouse)
	if !mid.get_region_rect().has_point(mouse):
		print (mouse)
		size.y += 100
		mid.set_region_rect(Rect2(pos,size))