extends Node2D

@onready var _rightSpawner_1= $Enemy_spawners/enemy_right_1
@onready var _rightSpawner_2 = $Enemy_spawners/enemy_right_2
@onready var _leftSpawner_1 = $Enemy_spawners/enemy_left_1
@onready var _leftSpawner_2 = $Enemy_spawners/enemy_left_2
@onready var enemyEntity:PackedScene = preload("res://Scenes/individual/male_zomble.tscn")
@onready var timer = $Timer
var enemyCap:int = 15
var enemySpawned:int = 0


func _ready():
	spawn(_rightSpawner_1)

func _process(delta):
	
	#if enemySpawned >enemyCap:
		#timer.stop()
	#elif timer.is_stopped():
		#timer.start()
		pass

func spawn(chosen):
	var en = enemyEntity.instantiate()
	en.position = chosen.position
	add_child(en)


func _on_timer_timeout():
	randomize()
	var options = [_rightSpawner_1,_rightSpawner_2,_leftSpawner_1,_leftSpawner_2]
	var rand_index:int = randi() % options.size()

	if options[rand_index]:
		spawn (options[rand_index])
	
