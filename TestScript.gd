extends Node2D
var startpoint : kinematicManager.point

# Called when the node enters the scene tree for the first time.
func _ready():
	
	startpoint = kinematicManager.point.new(Vector2(350,350),50)
	
	var prevPoint = startpoint
	for i in range(5):
		prevPoint.child = kinematicManager.point.new(Vector2(350,350),40)
		prevPoint = prevPoint.child
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	kinematicManager.inverse_kinematics(startpoint,get_global_mouse_position(),
		-sign(startpoint.loc.x - get_global_mouse_position().x))
	
	
	queue_redraw()
	pass

const lineColor : Color = Color.PERU
const lineThickness = 3

func _draw():
	
	var currPoint = startpoint
	while (currPoint.child != null):
		draw_line(currPoint.loc,currPoint.child.loc,lineColor,lineThickness)
		currPoint = currPoint.child
		
	draw_line(currPoint.loc,currPoint.loc.move_toward(get_local_mouse_position(),currPoint.size),lineColor,lineThickness)
	
	pass
