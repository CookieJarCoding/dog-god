extends Control

@onready var _destroy_world_label = $DestroyWorld
@onready var _read_diary_label = $ReadDiary


func _on_destroy_world_area_body_entered(body: Node2D) -> void:
	_set_choice_active(_destroy_world_label)


func _on_destroy_world_area_body_exited(body: Node2D) -> void:
	_set_choice_inactive(_destroy_world_label)


func _on_read_diary_area_body_entered(body: Node2D) -> void:
	_set_choice_active(_read_diary_label)


func _on_read_diary_area_body_exited(body: Node2D) -> void:
	_set_choice_inactive(_read_diary_label)


func _set_choice_active(label: Label) -> void:
	label.position -= Vector2(0, 5)
	label.label_settings.font_color = Color("#C9C9C9")


func _set_choice_inactive(label: Label) -> void:
	label.position += Vector2(0, 5)
	label.label_settings.font_color = Color("#969696")
