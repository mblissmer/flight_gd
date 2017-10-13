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
var hitNormal
var reflect = false

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
	
	# move mid
	var gpos = mid.get_global_pos()
	var endPointX = gpos.x
	if end.is_visible():
		end.hide()
	if firing:
		if hitPoint != null:
			endPointX = hitPoint.x
			if end.is_hidden():
				end.show()
		else: 
			endPointX = 0
	var endpos = Vector2(endPointX, gpos.y)
	var size = mid.get_region_rect().size
	size.y = gpos.distance_to(endpos)
	mid.set_region_rect(Rect2(mid.get_pos(),size))

	# animate end if showing
	if end.is_visible():
		end.set_global_pos(Vector2(hitPoint.x,gpos.y))
		var erot = end.get_rot()
		erot += turnSpeed * delta / 2
		if erot > PI*2:
			erot -= PI*2
		end.set_rot(erot)


func _fixed_process(delta): 
	if firing:
		var rect = mid.get_region_rect()
		var gpos = mid.get_global_pos()
		var space_state = get_world_2d().get_direct_space_state()
		rayPoints.clear()
		reflect = false
		var nearestHit
		var hitCount = 0
		for i in range(rayCount):
			var globalPointY = rayDistance*i + gpos.y - rect.size.x/2
			var ray = space_state.intersect_ray(
			Vector2(gpos.x,globalPointY), 
			Vector2(0,globalPointY))
			if (not ray.empty()):
				hitCount += 1
				if nearestHit == null:
					nearestHit = ray.position
				else:
					var oldDist = nearestHit.distance_to(gpos)
					var newDist = ray.position.distance_to(gpos)
					if newDist < oldDist:
						nearestHit = ray.position
				rayPoints.append(ray.position)
				if ray.collider.get_name() == "Shield":
					reflect = true
					if hitNormal == null:
						hitNormal = ray.normal
					else:
						hitNormal += ray.normal
			else: rayPoints.append(Vector2(0,globalPointY))
		hitPoint = nearestHit
		if hitNormal != null:
			hitNormal = hitNormal / hitCount
		
		if reflect:
#			print(hitPoint)
			print(hitNormal)
#			var ray = space_state.intersect_ray(
#			Vector2(gpos.x,globalPointY), 
#			Vector2(0,globalPointY))
	update()
#
func _draw():
	if reflect:
		var gpos = mid.get_global_pos()
		var localHit = hitPoint-gpos
		var endPos = Vector2(1000*sin(hitNormal.x/360), 1000*cos(hitNormal.y/360))
		draw_line(localHit,
		endPos, 
		Color(0,0,255),
		10)