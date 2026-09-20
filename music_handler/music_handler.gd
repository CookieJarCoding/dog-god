extends Node2D

@onready var light = $BaseMusic
@onready var dark = $DarkMusic

func _ready() -> void:
	light.volume_db = 0
	dark.volume_db = -80.0

func set_music_light(m: String) -> void:
	light.stream = load(m)
	light.play()

func set_music_dark(m: String) -> void:
	dark.stream = load(m)
	dark.play()

func switch_to_light() -> void:
	dark.volume_db = -80.0
	light.volume_db = 0
	
func switch_to_dark() -> void:
	light.volume_db = -80.0
	dark.volume_db = 0
