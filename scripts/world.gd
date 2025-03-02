extends Node2D

@onready var player = $player
@onready var minimap = $Minimap

func _ready() -> void:
	if minimap:
		minimap._initialize_minimap() 
		if player:
			minimap.player_node = player
		else:
			print("Player not found in World!")
	else:
		print("Minimap not found in World!")

func _process(delta: float) -> void:
	pass
