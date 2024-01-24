extends Node2D
var startpoint
var points = []
var visualPoints : Array[Vector2] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	
	startpoint = kinematicManager.point.new(Vector2(350,350),50)
	points.append(startpoint)
	visualPoints.append(startpoint.loc)
	for i in range(4):
		points.append(kinematicManager.point.new(Vector2(125,100),50))
		visualPoints.append(points[points.size()-1].loc)
	
	for i in range(points.size()):
		if (points.size()-1 != i): points[i].child = points[i+1]
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	points[points.size()-1].loc = get_global_mouse_position()
	
	if (startpoint.loc.x < get_global_mouse_position().x): kinematicManager.inverse_kinematics(startpoint,get_global_mouse_position(),1)
	else: kinematicManager.inverse_kinematics(startpoint,get_global_mouse_position(),-1)
	
	for i : int in range(0,visualPoints.size()):
		visualPoints[i] = lerp(visualPoints[i],points[i].loc,0.2)
	
	
	queue_redraw()
	pass

func _draw():
	
	
	for i : int in range(visualPoints.size()):
		
		if (i < visualPoints.size()-1):
			draw_line(visualPoints[i],visualPoints[i+1],Color.ORANGE,3)
		else:draw_line(visualPoints[i],visualPoints[i].move_toward(get_global_mouse_position(),points[i].size),Color.ORANGE,3)
		
		draw_arc(visualPoints[i],5,0,360,24,Color.AQUAMARINE,4)
	
	
	pass
