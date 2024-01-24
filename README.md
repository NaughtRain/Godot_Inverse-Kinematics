# Godot_Inverse-Kinematics
A custom inverse kinematics script for the godot engine.

it is done using a tree of points, where each point has a single child point - except from the last point in the sequence.
Because of this, you only need to store a reference to the first point in the tree,
however the "TestScript" stores them all in an array, as it also has "VisualPoints"
