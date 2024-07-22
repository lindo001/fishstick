extends Area2D

enum EFFECT {
	HP,
	AMMO,
	ARMOR
}
@export var default_value = 10
@export var effect:EFFECT

func _on_body_entered(body):
	
	if body.is_in_group("player"):
		
		body.change_status(effect,default_value)
		
