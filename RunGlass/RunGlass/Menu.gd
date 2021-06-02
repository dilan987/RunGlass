extends Control

export (PackedScene) var Scene

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_play_pressed():
	get_tree().change_scene_to(Scene)


func _on_salir_pressed():
	get_tree().quit()
