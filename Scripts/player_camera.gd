extends Camera2D

var  shake_amount:float = 0
var default:Vector2 = offset
var pos_x:int
var pos_y:int
@onready var timer:Timer = $Timer
@onready var tween:Tween = create_tween()


func _ready():
	set_process(true)
	#Global.camera = self
	randomize()
	
	
func _process(delta):
	offset = Vector2(randf_range(-1,1)*shake_amount,randf_range(-1,1)*shake_amount)

func shake(time,amount):
	timer.wait_time = time
	shake_amount = amount
	set_process(true)
	timer.start()


func _on_timer_timeout():
	set_process(false)
	tween.interpolate_value(self,"offset",1,1,Tween.TRANS_LINEAR,Tween.EASE_IN)
