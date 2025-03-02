extends Node2D

@onready var player = $"../player"
@onready var minimap = $"../Minimap"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if minimap and player:
		minimap.player_node = player
