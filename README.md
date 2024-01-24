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

