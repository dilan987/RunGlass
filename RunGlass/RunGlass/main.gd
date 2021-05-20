extends Node2D

var vidasjugador= 3
var monedas = 1
var ofset_vidas =80
export (PackedScene) var sprite_vidas
export (PackedScene) var sprite_monedas
onready var animacion_moneda = $moneda/animacionmoneda
onready var animacion_moneda2 = $moneda2/animacionmoneda
onready var animacion_moneda3 = $moneda3/animacionmoneda
onready var animacion_moneda4 = $moneda4/animacionmoneda 
onready var animacion_moneda5 = $moneda5/animacionmoneda
onready var animacion_moneda6 = $moneda6/animacionmoneda
onready var animacion_moneda7 = $moneda7/animacionmoneda
onready var animacion_moneda8 = $moneda8/animacionmoneda
onready var animacion_moneda9 = $moneda9/animacionmoneda
onready var animacion_moneda10 = $moneda10/animacionmoneda
onready var animacion_moneda11 = $moneda11/animacionmoneda
onready var animacion_moneda12 = $moneda12/animacionmoneda
onready var animacion_moneda13 = $moneda13/animacionmoneda
onready var animacion_moneda14 = $moneda14/animacionmoneda





var balaR= preload ("res://balita.tscn")

func _input(event):
	if event.is_action_pressed("disparar"):
		var bala = balaR.instance()
		bala.fire($Glass.global_position, get_global_mouse_position())
		bala.global_position= $Glass.global_position
		add_child(bala)
		
func _ready():
	crearvidas()
	crearmonedas()
	animacion_moneda.play("movimiento")
	animacion_moneda2.play("movimiento")
	animacion_moneda3.play("movimiento")
	animacion_moneda4.play("movimiento")
	animacion_moneda5.play("movimiento")
	animacion_moneda6.play("movimiento")
	animacion_moneda7.play("movimiento")
	animacion_moneda8.play("movimiento")
	animacion_moneda9.play("movimiento")
	animacion_moneda10.play("movimiento")
	animacion_moneda11.play("movimiento")
	animacion_moneda12.play("movimiento")
	animacion_moneda13.play("movimiento")
	animacion_moneda14.play("movimiento")
	
	
	
	
	
func crearvidas():
	for i in vidasjugador:
		var vida = sprite_vidas.instance()
		get_tree().get_nodes_in_group("gui")[0].add_child(vida) 
		#vida.global_position.x += 30 * i
		
		
		
	
func crearmonedas():
	for l in monedas:
		var moneda = sprite_monedas.instance()
		get_tree().get_nodes_in_group("gui")[0].add_child(moneda) 		
		
		
	

