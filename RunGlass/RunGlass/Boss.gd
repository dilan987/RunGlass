extends KinematicBody2D

onready var sprite = $AnimatedSprite
onready var animacion = $AnimationPlayer

enum {
	ATTACK1,
	ATTACK2,
	HURT,
	IDLE,
	WAIT
}

signal Attack1
signal Stop_attack
signal RebootTimer
var Time_attack = 1
var Time_Charge = 0
var state = WAIT
var player_entry = false
var Player = null
var Bullet = null
var Health = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	animacion.play("estaticos_boss")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	emit_signal("RebootTimer")
	
	match state:
		WAIT:
			if player_entry == true:
				print("Jugador entro")
				state = IDLE
			else:
				state = WAIT
		IDLE:
			$AttackPlayer.monitoring = false
			$AttackPlayer/CollisionShape2D.disabled = true
			yield(get_tree().create_timer(3), "timeout")
			RebootTimer()	
			state = ATTACK1
		ATTACK1:
			print("ataque1")
			if Time_Charge < Time_attack:
				emit_signal("Attack1")
				$AttackPlayer.monitoring = true
				$AttackPlayer/CollisionShape2D.disabled = false
				Time_Charge += delta
			else:
				emit_signal("Stop_attack")
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
#		$Timer.start()
		$BulletD/CollisionCabeza.call_deferred("set_disabled", true)
#		if $Timer.wait_time <= 0:
#				queue_free()
#				$CollisionCuerpo.call_deferred("set_disabled", true)
		Amount = 0
		print("Health =", 0)
		

func _on_PlayerEntry_body_entered(body):
	if body.is_in_group("heroe"):
		player_entry = true


func _on_BulletD_area_entered(area):
	if area.is_in_group("Balas"):
		Bullet = area
		var Amount = 5
		Take_Damage(Amount)
		print_debug("Health =", 0)	
		state = HURT


func _on_AttackPlayer_body_entered(body):
	if body.is_in_group("heroe"):
		Player = body
		Player.get_tree().get_nodes_in_group("heroe")[0].Lose_Life(1)


func _on_AttackPlayer_body_exited(body):
	if body.is_in_group("heroe"):
		Player = null


func RebootTimer():
	yield(get_tree().create_timer(4), "timeout")
	Time_Charge = 0
