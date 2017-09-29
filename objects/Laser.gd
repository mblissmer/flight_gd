extends RayCast2D

var mid
var start
var end
var midScale
var midScaleMin
var midScaleMax
var turnSpeed = 2
var minTurnSpeed = 2
var maxTurnSpeed = 15
var minStartScale = 0.5
var maxStartScale = 1
var scale
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
	scale = minStartScale
	start.set_scale(Vector2(scale,scale))
	set_process(true)
	
func _process(delta):
	if fireLaser and !firing:
		if timer < timeLimit:
			timer += delta
			var perc = timer/timeLimit
			turnSpeed = minTurnSpeed + ((maxTurnSpeed-minTurnSpeed)*perc)
			scale = minStartScale + ((maxStartScale-minStartScale)*perc)
		else:
			timer = 0
			scale = maxStartScale
			firing = true
		start.set_scale(Vector2(scale,scale))
	
	if firing and !fireLaser:
		firing = false
	
	if !firing and !fireLaser and turnSpeed > minTurnSpeed:
		if timer < timeLimit:
			timer += delta
			var perc = timer/timeLimit
			turnSpeed = maxTurnSpeed - ((maxTurnSpeed-minTurnSpeed)*perc)
			scale = maxStartScale - ((maxStartScale-minStartScale)*perc)
		else:
			timer = 0
			scale = minStartScale
			turnSpeed = minTurnSpeed
		start.set_scale(Vector2(scale,scale))

	
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


	# move mid
	var pos = mid.get_pos()
	var gpos = mid.get_global_pos()
	set_cast_to(Vector2(pos.x-2000,pos.y))
	if firing:
		if is_colliding():
			endPointX = get_collision_point().x
			end.set_global_pos(get_collision_point())
			if end.is_hidden():
				end.show()
			var erot = end.get_rot()
			erot += turnSpeed * delta
			if erot > PI*2:
				erot -= PI*2
			end.set_rot(erot)
		else:
			if end.is_visible():
				end.hide()
			endPointX = pos.x-2000
	else: endPointX = gpos.x
	var endpos = Vector2(endPointX, gpos.y)
	var size = mid.get_region_rect().size
	size.y = gpos.distance_to(endpos)
	mid.set_region_rect(Rect2(pos,size))
	
	#move end
#	end.set_pos(mouse)

func drawEnding():
	
	end.show()