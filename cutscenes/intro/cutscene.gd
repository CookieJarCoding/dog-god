extends Dialogue
class_name Cutscene


const images := [
	preload("res://cutscenes/intro/gfx/cutscene-cg-1.png"),
	preload("res://cutscenes/intro/gfx/cutscene-cg-2.png")
]

@onready var scene_image := $Base/V/Top/SceneImage

var image_index := 0


## Overrides Dialogue
func _enter_tree() -> void:
	pass


## Overrides Dialogue
func _ready() -> void:
	dialogue_label = $Base/V/Bottom/SceneText
	
	# NOTE/WARNING: THIS IS JANK
	pause_calculator = $PauseCalculator
	pause_timer = $PauseTimer
	blip = $DialogueBlip
	is_fully_visible = true
	message_speed = 8.0
	
	RenderingServer.set_default_clear_color(Color("#1f1f1f"))


## Overrides Dialogue
func slide_down() -> void:
	is_fully_visible = false


## Overrides Dialogue
func slide_up() -> void:
	is_fully_visible = true


func display_next_image() -> void:
	image_index += 1
	scene_image.texture = images[image_index]
