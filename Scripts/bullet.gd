extends Area2D
@export var damageAmount:int = 10
var moveSpeed:int = 30
var direction:Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x +=moveSpeed


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body.is_in_group("player") or body.is_in_group("enemies"):
		#queue_free()
		pass
	
