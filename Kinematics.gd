extends Node

## called for each point, used to calculate the position it should be in
func calculate_point(startPoint : point,targetPoint : point, targetLoc : Vector2,weight : int = -1):
	
	#region Get radius of base circle!
	var currPoint = startPoint
	var startRadiusMax = 0
	var prevPoint = null
	while(currPoint!=null and currPoint!=targetPoint):
		startRadiusMax += currPoint.size
		currPoint = currPoint.child
	#endregion
	var pointTogoTo = circle_intercections(startPoint.loc,startRadiusMax,targetLoc,targetPoint.size)[float(sign(weight))/2+0.5]
	
	targetPoint.loc = pointTogoTo

## loops through all points and calls "calculate_point" on them!
func inverse_kinematics(startpoint : point, targetLoc : Vector2, weight : int = -1):
	
	var allPoints = []
	var currPoint = startpoint
	
	while (currPoint != null):
		allPoints.append(currPoint)
		currPoint = currPoint.child
	allPoints.reverse()
	var currentTarget = targetLoc
	
	for i : point in allPoints:
		if (i == startpoint): continue
		calculate_point(startpoint,i,targetLoc,weight)
		targetLoc = i.loc

## finds the intersecting points between two circles. returns the closest possible point from circ1 if they are not intersecting
func circle_intercections(circ1 : Vector2,circ1_rad : int, circ2 : Vector2, circ2_rad : int) -> Array[Vector2]:
	
	#region early return --> circles not intersecting
	if (circ1.distance_to(circ2) > circ1_rad + circ2_rad):
		return [
			circ1.move_toward(circ2,circ1_rad),
			circ1.move_toward(circ2,circ1_rad)
		]
	#endregion
	
	#region find intersection points
	var closestpoints = [
		circ1 + circ1.direction_to(circ2)*circ1_rad,
		circ2 + circ2.direction_to(circ1)*circ2_rad
	] 
	var betweenPoint : Vector2 = (closestpoints.max() - closestpoints.min())/2 + closestpoints.min()
	var up_from_between = betweenPoint.direction_to(circ1).rotated(deg_to_rad(-90))
	#endregion
	
	return [
		(circ2.direction_to(circ1).rotated(-acos(circ2.distance_to(betweenPoint)/circ2_rad)))*circ2_rad+circ2,
		(circ2.direction_to(circ1).rotated(acos(circ2.distance_to(betweenPoint)/circ2_rad)))*circ2_rad+circ2,
	]


class point:
	var loc : Vector2
	var size
	var child : point
	
	func _init(inLoc : Vector2, inSize : int, inchild : point = null):
		
		loc = inLoc
		size = inSize
		child = inchild
		pass
	
	func _getChild(): return child
	
	pass
