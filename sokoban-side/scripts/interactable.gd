extends Node2D
class_name Interactable

# Interactable: immovable grid entities that can be "picked up" by the player
# Has state which dictates if it has been picked up or not

var tile := Vector2i.ZERO
var is_active := true

func _enter_tree() -> void:
	Level.interactables.append(self)
	
func _exit_tree() -> void:
	Level.interactables.erase(self)

func _ready() -> void:
	tile = (Vector2i(position) - Level.TILE_SIZE / 2) / 16
	position = tile * Vector2i(16, 16) + Level.TILE_SIZE / 2
	
func on_pickup() -> void:
	pass

func deactivate() -> void:
	pass
