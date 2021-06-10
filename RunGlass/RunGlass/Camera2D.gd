extends Camera2D

var shake_power = 20
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
		elapsedtime = 0
		shake(delta)
	else:
		offset = curPos 

func shake(delta):
	if elapsedtime<shake_time:
		offset =  Vector2(randf(), randf()) * shake_power
		elapsedtime += delta
	else:
		offset = curPos
		emit_signal("Stop_PlTD")      

func _on_Boss_Attack1():
	isShake = true

func _on_Boss_Stop_attack():
	isShake = false
