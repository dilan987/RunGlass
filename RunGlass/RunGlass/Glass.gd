extends KinematicBody2D

var direccion = Vector2()
var velocidad = 280
var JumpForce = -450
var gravedad = 14
var direccion_arriba = Vector2(0,-1)
var Life = 3
onready var sprite = $AnimatedSprite
onready var animacion = $AnimationPlayer

signal Life

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		sprite.flip_h=false
		animacion.play("correr")
		direccion.x=velocidad
		
	elif Input.is_action_pressed("ui_left"):
		direccion.x=-velocidad
		sprite.flip_h=true
		animacion.play("correr")
		
	else:
		direccion.x=0
		animacion.stop(true)
	
	if Input.is_action_pressed("ui_up") and is_on_floor():
		direccion.y= JumpForce
	
			
		
	if not is_on_floor():
		direccion.y += gravedad
	move_and_slide(direccion,direccion_arriba)
	if(get_slide_collision(get_slide_count()-1)!=null):
		var colisionador =get_slide_collision(get_slide_count()-1).collider
		if(colisionador.is_in_group("enemigos")):
			Lose_Life()
#			get_tree().get_nodes_in_group("heroe")[0].respawn()
			emit_signal("Life", Life)
			print(Life)
			yield(get_tree().create_timer(1), "timeout")
		if(colisionador.is_in_group("objetos-malos")):
#			Life *= -1
			get_tree().get_nodes_in_group("heroe")[0].respawn()
			emit_signal("Life", Life)

#	if Life == 0:
#		get_tree().get_nodes_in_group("heroe")[0].respawn()
			 
func respawn():
	get_tree().get_nodes_in_group("heroe")[0].global_position = get_tree().get_nodes_in_group("spawn")[0].global_position
	

func Lose_Life():
	if Life <= 0:
		Life = 0
	else:
		Life =  Life -1
