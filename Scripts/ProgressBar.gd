extends CanvasLayer

@export var player:CharacterBody2D
@onready var armer = $Armer
@onready var texture_progress_bar:TextureProgressBar = $TextureProgressBar
var i = 0
func _ready():
	player.healthChanged.connect(update)
	update()

func update():
	texture_progress_bar.value = player.currentHealth *100/player.maxHealth
	i +=1
	armer.text = str(i)
