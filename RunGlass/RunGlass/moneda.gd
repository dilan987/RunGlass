extends Area2D

signal coin_collected

func _on_moneda_body_entered(body):
	if body.is_in_group("heroe"):
		emit_signal("coin_collected")
		queue_free()
		get_tree().get_nodes_in_group("sfx")[0].get_node("2").play()
