extends VBoxContainer

@onready var main_menu: VBoxContainer = $"../Buttons"
@onready var debug_menu: VBoxContainer = self
@onready var focus_mark: Label = $/root/BaseControl/FocusMark

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_back_pressed() -> void:
	debug_menu.hide()
	main_menu.show()
	main_menu.get_children()[0].grab_focus.call_deferred()

func _on_slot_1_pressed() -> void:
	pass # Replace with function body.

func _on_slot_2_pressed() -> void:
	pass # Replace with function body.

func _on_slot_3_pressed() -> void:
	pass # Replace with function body.

func _on_slot_4_pressed() -> void:
	pass # Replace with function body.
