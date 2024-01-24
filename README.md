# Godot_Inverse-Kinematics
A custom inverse kinematics script for the godot engine.

# INSTRUCTIONS 
it is done using a tree of points, where each point has a single child point - except from the last point in the sequence.
Because of this, you only need to store a reference to the first point in the tree.
You can then use the "KinematicManager.inverse_kinematics" subroutine in the main loop to make the points move correctly. 

# HOW IT WORKS
The "KinematicManager.inverse_kinematics" subroutine is the only one that the user needs to call -
it creates an array of all the points, then calls the "calculate_point" subroutine using the point, and the location of the previous point
(or the target location, for the first time it is called).

The "calculate_point" subroutine adds together the radius of every point before the current point, and calls the
"circle_intersections" function to find where the point should be located.
(Since the "circle_intersections" function returns two options, it uses the "weight" parameter to find which one it should use.)

the "circle_intersections" function finds the two intersection points of two circles.
if the circles are not intersecting, it returns the closest possible position to circle2 from circle1 -
this is to ensure that the arm does not extend further than it should, when the target position is placed further than it can reach.
It then finds the closes position from both of the circles - then finds the direction it needs to travel to go "up" relative to both of the circles.
It then uses some triganometry to find the distance it needs to travel "up" to get to the intersection point.
It returns two options - the middle point plus the distance "up" , and the middle point minus the distance "up"

