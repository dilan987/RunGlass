extends Camera2D

signal Attack1;
var shake_power = 4
var isShake = false
var shake_time = 0.4
var elapsedtime = 0
var curPos

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	curPos = offset


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isShake == true:
		shake(delta)  

func shake(delta):
	if elapsedtime<shake_time:
		offset =  Vector2(randf(), randf()) * shake_power
		elapsedtime += delta
	else:
		isShake = false
		elapsedtime = 0
		offset = curPos     

func _on_Boss_Attack1():
	isShake = true
	emit_signal("Attack1")
