extends Area2D

signal coin_collected

func _on_moneda_body_entered(body):
	if body.is_in_group("heroe"):
		emit_signal("coin_collected")
		queue_free()
