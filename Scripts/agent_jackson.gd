extends CharacterBody2D



var bullet:PackedScene = preload("res://Scenes/individual/bullet.tscn")
var moveSpeed:int = 70
var normalAni:bool = true
var maxHealth:int = 100
var currentHealth:int = maxHealth 
var isFacingRight:bool = true
signal healthChanged 
@onready var marker:Marker2D = $Marker2D
@onready var sprite = $AnimatedSprite2D
@onready var close_range = $HitBox/CollisionShape2D
@onready var hurt_box = $HurtBox/CollisionShape2D
@onready var hit_box = $HitBox/CollisionShape2D
@onready var close_range_left = $HitBox_left/CollisionShape2D
@onready var collision_shape = $CollisionShape2D
@onready var player_camera = $Player_Camera
@onready var gun_sound= $AudioStreamPlayer2D




func _physics_process(delta):
	if currentHealth<1:
		death()
	
	if Input.is_action_just_pressed("fire") &&currentHealth>0:
		normalAni = false
		sprite.play("Shoot")
		fire()
		velocity.x  = 0
		velocity.y=0
	elif  Input.is_action_just_pressed("second_attack") &&currentHealth>0:
		normalAni = false
		sprite.play("Attack_0")
		if isFacingRight:
			close_range_left.disabled = false
		else:
			close_range.disabled = false
		velocity.x  = 0
		velocity.y=0
	if Input.is_action_pressed("down") &&normalAni&&currentHealth>0:
		velocity.y = moveSpeed
		velocity.x = 0
		sprite.play("Walk")
	elif  Input.is_action_pressed("up")&& normalAni&&currentHealth>0:
		velocity.y =-moveSpeed
		velocity.x = 0
		sprite.play("Walk")
	elif Input.is_action_pressed("left")&&normalAni&&currentHealth>0:
		velocity.x = -moveSpeed
		velocity.y = 0
		sprite.flip_h = true
		isFacingRight = sprite.flip_h
		#sprite.scale.x = sprite.scale.x
		sprite.play("Walk")
	elif  Input.is_action_pressed("right")&& normalAni&&currentHealth>0:
		velocity.x = moveSpeed
		velocity.y = 0
		sprite.flip_h =false
		isFacingRight = sprite.flip_h
		#sprite.scale.x = -sprite.scale.x
		
		sprite.play("Walk")
	else:
		if normalAni&&currentHealth>0:
			velocity.x = 0
			velocity.y = 0
			sprite.play("Idle")
	move_and_slide()

func movement(current_velocity):
	pass

func death():
	sprite.play("Dead")
func fire():
	var insta = bullet.instantiate()
	insta.XdirectionRight = !isFacingRight
	insta.position = marker.position
	add_child(insta)
	gun_sound.play()
	player_camera.shake(0.2,1) 
	



func _on_hurt_box_area_entered(area:Area2D):
	#print("Something entered HitBox")
	#if area.is_in_group("Bullet"):
		#healthChanged.emit()
		#currentHealth = currentHealth - area.damageAmount
	if area.is_in_group("enemy_strike"):
		healthChanged.emit()
		
		currentHealth = currentHealth - area.get_parent().damageAmount




func _on_animated_sprite_2d_animation_finished():
	if sprite.animation == "Shoot":
		normalAni = true
	if sprite.animation == "Dead":
		#queue_free()
		hit_box.disabled = true
		hurt_box.disabled = true
		collision_shape.disabled =true
		set_physics_process(false)
	if sprite.animation == "Attack_0":
		normalAni = true
		close_range.disabled = true
		close_range_left.disabled =true
