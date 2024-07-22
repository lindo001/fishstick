extends  Control


@onready var label = $Dialog/Label

@onready var user = $"Agent Jackson"
var text:Array = ["Damn it, there all over the building! I need to get out of here.",
"Where should i go now?"]
var i = -1


func _physics_process(delta):
	if i>text.size():
		print("onn")
	elif Input.is_action_just_pressed("ui_accept") && i<text.size()-1:
		i+=1
		label.text = text[i]
	elif Input.is_action_just_pressed("ui_home"): 
		get_tree().change_scene_to_file("res://Scenes/Compact/world.tscn")

