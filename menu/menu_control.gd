extends VBoxContainer

@onready var main_menu: VBoxContainer = self
@onready var focus_mark: Label = $/root/BaseControl/FocusMark

var credits := preload("res://menu/credits.tscn")

func _ready() -> void:
	get_viewport().gui_focus_changed.connect(_on_button_focus_changed)
	main_menu.get_children()[0].grab_focus.call_deferred()
	PaletteSwapper.set_palette(PaletteList.ATTIC)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://cutscenes/intro/intro_cutscene.tscn")

func _on_credits_pressed() -> void:
	get_viewport().gui_disable_input = true
	var instance := credits.instantiate()
	get_tree().current_scene.add_child(instance)
	await instance.tree_exited
	get_viewport().gui_disable_input = false

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_button_focus_changed(control) -> void:
	focus_mark.position.y = control.global_position.y + 1
