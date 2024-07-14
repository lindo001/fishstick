extends Control


var  peer = ENetMultiplayerPeer.new()
@export var  player_template:PackedScene
@export var default_port = 155


 


func _on_host_pressed():
	peer.create_server(default_port)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(this_player)
	this_player()
	
func this_player(id = 1):
	var player = player_template.instantiate()
	player.name = str(id)
	call_deferred("add_child",player)
	pass

func _on_join_pressed():
	peer.create_client("localhost",default_port)
	multiplayer.multiplayer_peer = peer
