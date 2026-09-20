extends VBoxContainer

@onready var main_menu: VBoxContainer = self
@onready var debug_menu: VBoxContainer = $"../DebugButtons"
@onready var focus_mark: Label = $/root/BaseControl/FocusMark

func _ready() -> void:
	get_viewport().gui_focus_changed.connect(_on_button_focus_changed)
	main_menu.get_children()[0].grab_focus.call_deferred()
	debug_menu.hide()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://sidescroll_system/rooms/backyard/backyard.tscn")

func _on_debug_pressed() -> void:
	main_menu.hide()
	debug_menu.show()
	debug_menu.get_children()[0].grab_focus.call_deferred()

func _on_credits_pressed() -> void:
	print("Credits")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_button_focus_changed(control) -> void:
	focus_mark.position.y = control.global_position.y + 1
