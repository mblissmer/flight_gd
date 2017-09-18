extends RayCast2D

var mid
var start
var end
var midOffset
var midScale
var midScaleMin
var midScaleMax
var turnSpeed = 5

func _ready():
	mid = get_node("Mid")
	start = get_node("Start")
	end = get_node("End")
	midScale = mid.get_scale()
	midScaleMin = midScale.x - (midScale.x * 0.05)
	midScaleMax = midScale.x + (midScale.x * 0.05)
	midOffset = mid.get_region_rect().size.height / 2
	set_process(true)
	
func _process(delta):
	# animate start
	var srot = start.get_rot()
	srot += turnSpeed * delta
	if srot > PI*2:
		srot -= PI*2
	start.set_rot(srot)
	
	# animate mid
	midScale.x = rand_range(midScaleMin,midScaleMax)
	mid.set_scale(midScale)
	
	# animate end
	var erot = end.get_rot()
	erot += turnSpeed * delta
	if erot > PI*2:
		erot -= PI*2
	end.set_rot(erot)
	
	# move mid
	var mouse = get_viewport().get_mouse_pos()
	mid.look_at(mouse)
	var pos = mid.get_pos() 
	var size = mid.get_region_rect().size
	size.y = pos.distance_to(mouse) / midScale.y + midOffset
	mid.set_region_rect(Rect2(pos,size))
	
	#move end
	end.set_pos(mouse)