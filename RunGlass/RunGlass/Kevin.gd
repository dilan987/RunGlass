extends KinematicBody2D

enum {
	PATROL,
	CHASE,
	HURT
}

export (int) var ACCELERATION = 300
export (int) var MAX_SPEED = 600
export (int) var FRICTION = 200

var state = PATROL
var Move = Vector2.ZERO
var SumMove = Vector2(1, 0)
var Direction
var Player = null
var Bullet = null

var Health = 60

func _process(delta):
	
	if $AnimatedSprite/AnimationPlayer.current_animation == "Entry":
		return
	
	match state:
		PATROL:
			$AnimatedSprite/AnimationPlayer.play("Patrol")
			Move = Vector2.ZERO
#			_on_Move(self.global_position, self.global_position + SumMove)
#			Move = Move.move_toward(Direction * MAX_SPEED, ACCELERATION * delta)
#			if self.global_position == self.global_position + SumMove:
#				Move = Vector2.ZERO
#				yield(get_tree().create_timer(1), "timeout")
#				_on_Move(self.global_position, self.global_position - SumMove)
#				Move = Move.move_toward(Direction * MAX_SPEED, ACCELERATION * delta)
#			elif self.global_position == self.global_position - SumMove:
#				Move = Vector2.ZERO
#				yield(get_tree().create_timer(1), "timeout")
#				_on_Move(self.global_position, self.global_position + SumMove)
#				Move = Move.move_toward(Direction * MAX_SPEED, ACCELERATION * delta)
		CHASE:
			if Player != null:
				$AnimatedSprite/AnimationPlayer.play("Attack")
				Direction = (Player.global_position - global_position).normalized()
				Move = Move.move_toward(Direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = PATROL
		HURT:
			if Bullet != null:
				$AnimatedSprite/AnimationPlayer.play("Hurt")
				Move = Vector2.ZERO
				yield(get_tree().create_timer(1), "timeout")
				state = CHASE
			if Bullet == null and Player == null:
				state = PATROL
				
	if Move.x < 0:
		$AnimatedSprite.flip_h = false
	else: 
		$AnimatedSprite.flip_h = true
	Move = move_and_slide(Move)

func _on_Move(Origin: Vector2, Des: Vector2):
	Direction = Origin.direction_to(Des)

func Take_Damage(Amount):
	Health -= Amount
	print("Health =", Health)
	if Health <= 0:
#		$AnimatedSprite/AnimationPlayer.play("Hurt")
		$Timer.start()
		$AreaPlDetector/PlayerD.call_deferred("set_disabled", true)
		$BulletDetector/BulletD.call_deferred("set_disabled", true)
		if $Timer.wait_time <= 0:
				queue_free()
				$CollisionPatrol.call_deferred("set_disabled", true)
		Amount = 0
		print("Health =", 0)
	
func _on_AreaPlDetector_body_entered(body):
	if body.is_in_group("heroe"):
		Player = body
		$AnimatedSprite/AnimationPlayer.play("Entry")
#		$CollisionAttack.call_deferred("set_disabled", false)
#		$CollisionPatrol.call_deferred("set_disabled", true)
		yield(get_tree().create_timer(1), "timeout")
		state = CHASE


func _on_Timer_timeout():
	queue_free()


func _on_BulletDetector_area_entered(area):
	if area.is_in_group("Balas"):
		Bullet = area
		var Amount = 20
		Take_Damage(Amount)
		print_debug("Health =", 0)	
		state = HURT


func _on_AreaPlDetector_body_exited(body):
	Player = null
