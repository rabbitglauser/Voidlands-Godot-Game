extends CanvasLayer

@onready var sub_viewport_container: SubViewportContainer = $UI/MarginContainer/SubViewportContainer
@onready var sub_viewport: SubViewport = $UI/MarginContainer/SubViewportContainer/SubViewport
@onready var Minimap_camera: Camera2D = $UI/MarginContainer/SubViewportContainer/SubViewport/MinimapCamera
@onready var player_marker: ColorRect = $UI/MarginContainer/SubViewportContainer/SubViewport/PlayerMarker

var player_node: Node2D

func _ready() -> void:
	print("Minimap Owner: ", owner)
	call_deferred("_initialize_minimap")

func _initialize_minimap() -> void:
	if owner:
		var tilemap_parent = owner.find_child("TileMap", true, false)
		
		if tilemap_parent:
			print("Found TileMap Parent: ", tilemap_parent.name)

			for tilemap in tilemap_parent.get_children():
				if tilemap is TileMap:
					var minimap_tilemap = tilemap.duplicate()
					setup_minimap(minimap_tilemap)

					if tilemap.name == "Ground":
						var used_rect: Rect2i = tilemap.get_used_rect()
						set_minimap_limits(used_rect)
		else:
			print("TileMap node not found under owner!")
	else:
		print("Owner is still null!")

func _process(delta: float) -> void:
	if player_node:
		Minimap_camera.global_position = Minimap_camera.global_position.lerp(player_node.global_position, 5 * delta)
		player_marker.global_position = player_node.global_position
	else:
		if owner:
			player_node = owner.get_node_or_null("Player")
			if player_node:
				print("Player node found: ", player_node.name)
			else:
				print("Player node not found!")

func setup_minimap(minimap_tilemap: TileMap) -> void:
	sub_viewport.add_child(minimap_tilemap)

func set_minimap_limits(used_rect: Rect2i) -> void:
	var tile_size = 16  # Adjust if your tile size is different
	Minimap_camera.limit_left = used_rect.position.x * tile_size
	Minimap_camera.limit_top = used_rect.position.y * tile_size
	Minimap_camera.limit_right = (used_rect.position.x + used_rect.size.x) * tile_size
	Minimap_camera.limit_bottom = (used_rect.position.y + used_rect.size.y) * tile_size
