extends KinematicBody2D

var direccion = Vector2()
var velocidad = 280
var JumpForce = -350
var gravedad = 14
var direccion_arriba = Vector2(0,-1)
onready var sprite = $AnimatedSprite
onready var animacion = $AnimationPlayer


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
			get_tree().get_nodes_in_group("heroe")[0].respawn()
		if(colisionador.is_in_group("objetos-malos")):
			get_tree().get_nodes_in_group("heroe")[0].respawn()
			 
func respawn():
	get_tree().get_nodes_in_group("heroe")[0].global_position = get_tree().get_nodes_in_group("spawn")[0].global_position
	

		
		
