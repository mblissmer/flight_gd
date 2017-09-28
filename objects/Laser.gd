extends RayCast2D

var mid
var start
var end
var midScale
var midScaleMin
var midScaleMax
var turnSpeed = 2
var minTurnSpeed = 2
var turnUpSpeed = 5
var firing = false
var endPointX = 0
var timer = 0
var timeLimit
var fireLaser = false

func _ready():
	mid = get_node("Mid")
	start = get_node("Start")
	end = get_node("End")
	midScale = mid.get_scale()
	midScaleMin = midScale.x - (midScale.x * 0.05)
	midScaleMax = midScale.x + (midScale.x * 0.05)
	set_process(true)
	
func _process(delta):
	if fireLaser and !firing:
		if timer < timeLimit:
			timer += delta
			turnSpeed += delta * turnUpSpeed
		else:
			firing = true
	
	if firing and !fireLaser:
		firing = false
	
	if !firing and !fireLaser and turnSpeed > minTurnSpeed:
		turnSpeed -= delta * turnUpSpeed

	
	# animate start
	var srot = start.get_rot()
	srot += turnSpeed * delta
	if srot > PI*2:
		srot -= PI*2
	start.set_rot(srot)
	
	# animate mid
	midScale.x = rand_range(midScaleMin,midScaleMax)
	mid.set_scale(midScale)
	
#	# animate end
#	var erot = end.get_rot()
#	erot += turnSpeed * delta
#	if erot > PI*2:
#		erot -= PI*2
#	end.set_rot(erot)

	# move mid
	var gpos = get_global_pos()
	if firing:
		endPointX = -100
	else: endPointX = gpos.x
	var endpos = Vector2(endPointX, gpos.y)
	var size = mid.get_region_rect().size
	size.y = gpos.distance_to(endpos)
	var pos = mid.get_pos()
	mid.set_region_rect(Rect2(pos,size))
	
	#move end
#	end.set_pos(mouse)