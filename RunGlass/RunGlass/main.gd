extends Node2D

var vidasjugador= 3
var monedas = 1
var score = 0
var ofset_vidas =80
export (PackedScene) var sprite_vidas
export (PackedScene) var sprite_monedas
onready var scoreLabText = get_node("GUI/RichTextLabel")
onready var animacion_moneda = $moneda/animacionmoneda
onready var animacion_moneda2 = $moneda2/animacionmoneda
onready var animacion_moneda3 = $moneda3/animacionmoneda
onready var animacion_moneda16 = $moneda16/animacionmoneda 
onready var animacion_moneda17 = $moneda17/animacionmoneda
onready var animacion_moneda18 = $moneda18/animacionmoneda
onready var animacion_moneda19 = $moneda19/animacionmoneda
onready var animacion_moneda20 = $moneda20/animacionmoneda
onready var animacion_moneda21 = $moneda21/animacionmoneda
onready var animacion_moneda22 = $moneda22/animacionmoneda
onready var animacion_moneda23 = $moneda23/animacionmoneda
onready var animacion_moneda24 = $moneda24/animacionmoneda
onready var animacion_moneda25 = $moneda25/animacionmoneda
onready var animacion_moneda26 = $moneda26/animacionmoneda





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
	animacion_moneda16.play("movimiento")
	animacion_moneda17.play("movimiento")
	animacion_moneda18.play("movimiento")
	animacion_moneda19.play("movimiento")
	animacion_moneda20.play("movimiento")
	animacion_moneda21.play("movimiento")
	animacion_moneda22.play("movimiento")
	animacion_moneda23.play("movimiento")
	animacion_moneda24.play("movimiento")
	animacion_moneda25.play("movimiento")
	animacion_moneda26.play("movimiento")
	
	
	
	
	
func crearvidas():
	for i in vidasjugador:
		var vida = sprite_vidas.instance()
		get_tree().get_nodes_in_group("gui")[0].add_child(vida) 
		#vida.global_position.x += 30 * i
		
		
		
	
func crearmonedas():
	for l in monedas:
		var moneda = sprite_monedas.instance()
		get_tree().get_nodes_in_group("gui")[0].add_child(moneda) 	
	
	
	
func _on_moneda_coin_collected():
	score = score + 1
	var scoreText = "Score: " + String(score)
	print(scoreText)
	scoreLabText.clear()
	scoreLabText.add_text(scoreText)
