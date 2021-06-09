extends KinematicBody2D
const Gravedad = 10
const Velocidad = 50
const Floor = Vector2(0, -1)
var player = null

var is_dead = false
var Health = 100
var Damage
var Movimiento = Vector2()

var Direccion = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if $AnimatedSprite/AnimationPlayer.current_animation == "Attack":
		get_tree().get_nodes_in_group("sfx")[0].get_node("3").play()
		return
	
	if is_dead == false:
		Movimiento.x = Velocidad * Direccion

		if Direccion == -1:
			$AnimatedSprite.flip_h = false
		elif Direccion == 1:
			$AnimatedSprite.flip_h = true
		$AnimatedSprite/AnimationPlayer.play("Walk")
		Movimiento.y += Gravedad

		Movimiento = move_and_slide(Movimiento, Floor)

		if is_on_wall():
			Direccion = Direccion * -1
			$RayCast2D.position.x *= -1
			$Area2DPl/CollisionShape2D.position.x *= -1
			$AttackDetector/CollisionShape2D.position.x *=-1

		if not $RayCast2D.is_colliding():
			Direccion = Direccion * -1
			$RayCast2D.position.x *= -1
			$Area2DPl/CollisionShape2D.position.x *= -1
			$AttackDetector/CollisionShape2D.position.x *=-1
		
#	if player:
#		Movimiento = position.direction_to(player.position) * Velocidad
#		if position.direction_to(player.position) == Vector2(1,0):
#			$AnimatedSprite.flip_h = true
#		Movimiento = move_and_slide(Movimiento)
			
	if is_dead == true:
		Movimiento = Vector2()
#		$AnimatedSprite.play("Death")
	
func dead(): 
	Movimiento = Vector2(0,0)
#	$AnimatedSprite.play("Death")
	$Timer.start()
	if $Timer.wait_time <= 0:
		$CollisionShape2D.call_deferred("set_disabled", true)
	queue_free()
		
func Take_damage(Amount):
	Health -= Amount
	print("Health =", Health)
	if Health <= 0:
		is_dead = true
		dead()
		Amount = 0
#		print_debug("Health =", 0)	
		
func hit():
	$AttackDetector.monitoring = true
	$AttackDetector/CollisionShape2D.disabled = false
	
func end_of_hit():
	$AttackDetector.monitoring = false
	$AttackDetector/CollisionShape2D.disabled = true
	
func start_walk():
	$AnimatedSprite/AnimationPlayer.play("Walk")

func _on_Timer_timeout():
	queue_free()

func _on_Area2DPl_body_entered(body):
	if body.is_in_group("heroe"):
		player = body
#		while(player !=null):
		$AnimatedSprite/AnimationPlayer.play("Attack")
#			yield(get_tree().create_timer(1), "timeout")

func _on_Area2DPl_body_exited(body):
	player = null


func _on_AttackDetector_body_entered(body):
	if body.is_in_group("heroe"):
		body.get_tree().get_nodes_in_group("heroe")[0].Lose_Life(1)
	else:
		body = null

func _on_Area2DB_area_entered(area):
	if area.is_in_group("Balas"):
		var Amount = 20
		Take_damage(Amount)
		print_debug("Health =", 0)	
		Movimiento = Vector2(0,0)
