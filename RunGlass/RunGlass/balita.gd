extends Sprite


var dir : Vector2
var speed = 750

func fire(origin:Vector2, dest : Vector2):
	dir= origin.direction_to(dest)
	
func _process(delta):
	if dir:
		global_position += dir * delta * 350


func BulletDir(dir, pos):
	pos = Vector2()
	set_rotation(dir)
	set_position(pos)
	dir = Vector2(speed, 0).rotated(dir)


func _on_VisibilityNotifier2D_screen_exited():
	print_debug("murio")
	queue_free()


func _on_Area2D_body_entered(body):
	if body.is_in_group("enemigos"):
		queue_free()
