extends Node

func _ready():
	pass # Replace with function body.

func Change_Bullet_Speed(bullet: Area2D, new_speed: float, time:float):
	var last_speed = bullet.velocity
	bullet.velocity = new_speed

	yield(get_tree().create_timer(time), "timeout")

	bullet.velocity = last_speed
	
func Change_Jump_Force(character: KinematicBody2D, new_Jforce: float, time:float):
	var last_Jforce
#	if character.Input.is_action_pressed("ui_up"):
	last_Jforce = character.JumpForce
	character.JumpForce = new_Jforce
	
	yield(get_tree().create_timer(time), "timeout")
	
	if last_Jforce == null || character.JumpForce == null:
		last_Jforce = -450
		character.JumpForce = -450
	character.JumpForce = last_Jforce
