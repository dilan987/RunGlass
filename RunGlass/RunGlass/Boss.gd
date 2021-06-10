extends KinematicBody2D

#onready var sprite = $AnimatedSprite
#onready var animacion = $AnimatedSprite/AnimationPlayer

enum {
	ATTACK1,
	ATTACK2,
	HURT,
	IDLE,
	WAIT
}

signal Attack1
signal Stop_attack
var Time_attack = 0.2
var Time_Charge = 0
var state = WAIT
var player_entry = false
var Player = null
var Bullet = null
var Health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.stop()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
#	if animacion.current_animation == "estaticos_boss":
#		return
		
	match state:
		
		WAIT:
			if player_entry == true:
				print("Jugador entro")
				state = IDLE
			else:
				state = WAIT
		IDLE:
			print("IDLE")
			$AnimatedSprite/AnimationPlayer.play("estaticos_boss")
#			sprite.play("estaticos_boss")
			yield(get_tree().create_timer(4), "timeout")
			RebootTimer()
			state = ATTACK1
		ATTACK1:
			if Time_Charge < Time_attack:
				print("ataque1")
#				sprite.play("ataque_boss")
				$AnimatedSprite/AnimationPlayer.play("ataque_boss")
				Time_Charge += delta
			elif Time_Charge >= Time_attack:
				state = IDLE
		HURT:
			if Bullet != null:
#				$AnimatedSprite/AnimationPlayer.play("Hurt")
				yield(get_tree().create_timer(1), "timeout")
				state = IDLE

func Take_Damage(Amount):
	Health -= Amount
	print("Health =", Health)
	if Health <= 0:
		$Timer.start()
		$BulletD/CollisionCabeza.call_deferred("set_disabled", true)
		$AnimatedSprite/AnimationPlayer.play("muerte_boss")
		if $Timer.wait_time <= 0:
				queue_free()
				$CollisionCuerpo.call_deferred("set_disabled", true)
		Amount = 0
		print("Health =", 0)
		

func hit():
	emit_signal("Attack1")
	$AttackPlayer.monitoring = true
	$AttackPlayer/CollisionShape2D.disabled = false
	
func End_hit():
	emit_signal("Stop_attack")
	$AttackPlayer.monitoring = false
	$AttackPlayer/CollisionShape2D.disabled = true

func _on_PlayerEntry_body_entered(body):
	if body.is_in_group("heroe"):
		player_entry = true


func _on_BulletD_area_entered(area):
	if area.is_in_group("Balas"):
		Bullet = area
		var Amount = 5
		Take_Damage(Amount)
		print_debug("Health =", Health)
		state = HURT


func _on_AttackPlayer_body_entered(body):
	if body.is_in_group("heroe"):
		Player = body
		Player.get_tree().get_nodes_in_group("heroe")[0].Lose_Life(1)


func _on_AttackPlayer_body_exited(body):
	if body.is_in_group("heroe"):
		Player = null


func RebootTimer():
	yield(get_tree().create_timer(6), "timeout")
	Time_Charge = 0


func _on_Timer_timeout():
	queue_free()
