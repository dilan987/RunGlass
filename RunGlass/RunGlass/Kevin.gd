extends KinematicBody2D

enum {
	PATROL,
	CHASE,
	HURT,
	DEATH,
}

export (int) var ACCELERATION = 300
export (int) var MAX_SPEED = 600
export (int) var FRICTION = 200

var state = PATROL
var Move = Vector2.ZERO
var range_move_max = 10
var range_move_min = 1
var Player = null
var Bullet = null

var Health = 60

#func _process(delta):
#	pass
	

#func _on_AreaPlDetector_body_entered(body):
#	if body.is_in_group("heroe"):
#		state = CHASE
#		$CollisionAttack.call_deferred("set_disabled", false)
#		$CollisionPatrol.call_deferred("set_disabled", true)
#		yield(get_tree().create_timer(1), "timeout")
#		$AnimatedSprite/AnimationPlayer.play("Attack")


#func _on_Timer_timeout():
#	queue_free()
#
#
#func _on_BulletDetector_area_entered(area):
#	if area.is_in_group("Balas"):
#		var Amount = 20
#		Take_Damage(Amount)
#		print_debug("Health =", 0)	
#		#Movimiento = Vector2(0,0)
