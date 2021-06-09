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
var Time_attack = 2
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
	match state:
		WAIT:
			if player_entry == true:
				print("Jugador entro")
				state = IDLE
			else:
				state = WAIT
		IDLE:
			yield(get_tree().create_timer(3), "timeout")
			Time_Charge = 0.7
			state = ATTACK1
		ATTACK1:
			print("ataque1")
			if Time_Charge < Time_attack:
				emit_signal("Attack1")
				Time_Charge += delta
			else:
				emit_signal("Stop_attack")
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
