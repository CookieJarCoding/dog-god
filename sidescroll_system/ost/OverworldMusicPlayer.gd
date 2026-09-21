extends Node

const HUMAN_MUSIC := preload("res://sidescroll_system/ost/home_ovrworld.mp3")

var _music_player: AudioStreamPlayer


func _ready() -> void:
	_music_player = AudioStreamPlayer.new()
	add_child(_music_player)


func play_human_music() -> void:
	if _music_player.stream == HUMAN_MUSIC and _music_player.playing:
		return
		
	_music_player.stream = HUMAN_MUSIC
	_music_player.play()


func stop_human_music() -> void:
	_music_player.stop()
