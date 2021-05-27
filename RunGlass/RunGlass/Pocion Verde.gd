extends Area2D


func _ready():
	pass # Replace with function body.
	
func _process(delta):
	pass

func _on_Pocion_Verde_body_entered(body):
	if body.is_in_group("heroe"):
		queue_free()
		Globals.Change_Jump_Force(body, -580.0, 15.0)
