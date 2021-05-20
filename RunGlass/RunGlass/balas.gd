extends KinematicBody2D


var dir : Vector2

func fire(origin:Vector2, dest : Vector2):
	dir= origin.direction_to(dest)
	
func _process(delta):
	if dir:
		global_position += dir+delta *350
