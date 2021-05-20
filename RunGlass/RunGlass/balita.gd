extends Sprite


var dir : Vector2

func fire(origin:Vector2, dest : Vector2):
	dir= origin.direction_to(dest)
	
func _process(delta):
	if dir:
		global_position += dir * delta * 350


func _on_VisibilityNotifier2D_screen_exited():
	print_debug("murio")
	queue_free()
