extends CharacterBody2D
@onready var health_bar:TextureProgressBar = $TextureProgressBar
@onready var raycast = $RayCast2D
@onready var hurt_box = $HurtBox
@onready var hit_box = $HitBox/CollisionShape2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var target:CharacterBody2D
@export var wipeOutDamagePoints:int =30
var direction = Vector2.LEFT
var max_health:int = 60
var current_health:int = max_health
var moveSpeed:int = 30
var normalAni:bool = true
var damageAmount = 10



func _on_hurt_box_area_entered(area:Area2D):
	
	if area.is_in_group("Bullet"):
		current_health= current_health - area.damageAmount
	if area.is_in_group("player_strike"):
		current_health = current_health - wipeOutDamagePoints


func _process(delta):
	#raycast.target_position(target.position)
	health_bar.value = current_health
	raycast.target_position
	if !raycast.is_colliding() && normalAni && current_health>0:
		direction = (target.position - global_position).normalized()
		raycast.target_position = direction * 40
		velocity = direction* moveSpeed
		animated_sprite_2d.play("Walk")
		if direction.x>0:
			animated_sprite_2d.flip_h = false
		else:
			animated_sprite_2d.flip_h = true
		move_and_slide()
	elif current_health>0:
			normalAni = false
			animated_sprite_2d.play("Attack")
			hit_box.disabled = false
	else:
		animated_sprite_2d.play("Death") 
	


func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation == "Attack":
		normalAni = true
		hit_box.disabled = true
	if animated_sprite_2d.animation == "Death":
		queue_free()
