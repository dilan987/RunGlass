extends KinematicBody2D

onready var sprite = $AnimatedSprite
onready var animacion = $AnimationPlayer

enum {
	ATTACK1,
	ATTACK2,
	HURT
}

# Called when the node enters the scene tree for the first time.
func _ready():
	animacion.play("estaticos_boss")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
