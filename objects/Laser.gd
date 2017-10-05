#extends RayCast2D

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
var rayCount = 10
var rect
var rayDistance
var rayPoints = []
var hitPoint

func _ready():
	mid = get_node("Mid")
	start = get_node("Start")
	end = get_node("End")
	midScale = mid.get_scale()
	midScaleMin = midScale.x - (midScale.x * 0.05)
	midScaleMax = midScale.x + (midScale.x * 0.05)
	scale = minStartScale
	start.set_scale(Vector2(scale,scale))
	rect = mid.get_region_rect()
	rayDistance = rect.size.x / (rayCount - 1)
	print (rayDistance)
	set_process(true)
	set_fixed_process(true)
	
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
		if end.is_visible():
			end.hide()
	
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
#	var pos = mid.get_pos()
#	var gpos = mid.get_global_pos()
#	topRC.set_cast_to(Vector2(pos.x-2000,pos.y))
#	bottomRC.set_cast_to(Vector2(pos.x-2000,pos.y))
#	if firing:
#		var isColliding = false
#		var whichRC
#		if topRC.is_colliding():
#			isColliding = true
#			whichRC = topRC
#		elif midRC.is_colliding():
#			isColliding = true
#			whichRC = midRC
#		elif bottomRC.is_colliding():
#			isColliding = true
#			whichRC = bottomRC
#		if isColliding:
#			endPointX = whichRC.get_collision_point().x
#			end.set_global_pos(whichRC.get_collision_point())
#			if end.is_hidden():
#				end.show()
#			var erot = end.get_rot()
#			erot += turnSpeed * delta
#			if erot > PI*2:
#				erot -= PI*2
#			end.set_rot(erot)
#		else:
#			if end.is_visible():
#				end.hide()
#			endPointX = pos.x-2000
#	else: endPointX = gpos.x
#	var endpos = Vector2(endPointX, gpos.y)
#	var size = mid.get_region_rect().size
#	size.y = gpos.distance_to(endpos)
#	mid.set_region_rect(Rect2(pos,size))

func _fixed_process(delta): 
#	var rect = mid.get_region_rect()
#	var pos = mid.get_pos()
#	var gpos = mid.get_global_pos()
	var space_state = get_world_2d().get_direct_space_state()
	rayPoints.clear()
	var nearestHit = 0
	for i in range(rayCount):
#		var localPointX = 0
		var localPointY = rayDistance*i-rect.size.x/2
		var globalPointX = mid.get_global_pos().x
		var globalPointY = rayDistance*i + mid.get_global_pos().y - rect.size.x/2
		rayPoints.append(localPointY)
#		print("Local: "  + str(localPointY) + ", Global: " + str(globalPointY))
		var ray = space_state.intersect_ray(Vector2(globalPointX,globalPointY), Vector2(0,globalPointY))
		if (not ray.empty()):
			print("Hit at point: ",ray.position)
			print(ray.position.distance_to(mid.get_global_pos()))
	update()

func _draw():
	for i in range(rayPoints.size()):
		draw_line(Vector2(0,rayPoints[i]),Vector2(-2000,rayPoints[i]), Color(255,0,0))