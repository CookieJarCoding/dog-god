extends Dialogue
class_name Cutscene

const backyard_scene := preload("res://sidescroll_system/world/humanworld.tscn")
const images := [
	preload("res://cutscenes/intro/gfx/cutscene-cg-1.png"),
	preload("res://cutscenes/intro/gfx/cutscene-cg-2.png")
]
const texts := [
	"For years,{p=0.5} the members of the CULT OF THE HOUND have prayed and pleaded to their God...{p=0.5} the HOUND OF TINDALOS.",
	"Legends say that THE HOUND does not exist within a comprehensible time,{p=0.5} but rather a place where everything has no meaning,{p=0.5} and nothing meant everything.",
	## FADEOUT HERE
	
	## IMAGE 1
	"It is a blood-thirsty being.{p=0.5} Hungering.",
	"Feasting on tiny,{p=0.2} irrelevant beings like us,{p=0.2} as we are so worthless.",
	"But every god has its favorites.",
	## FADEOUT HERE
	
	## IMAGES 2 - 7
	"We, THE HOUND'S KEEPERS, call upon it.",
	"Begging.",
	"Pleading for salvation from its fate.",
	"We sacrifice our imperfect world for our perfect being.",
	## SCROLL IMAGE UP FROM HERE
	
	## IMAGE 8
	"And at last,{p=0.5} after generations of prayer.{p=0.2}.{p=0.2}.", 
	".{p=0.2}.{p=0.2}.{p=0.5}we feel our god is answering."
]

@onready var scene_image: TextureRect = $SceneImage
@onready var particles := $Particles
@onready var particle_burst := $ParticleBurst

var image_index := 0


## Overrides Dialogue
func _enter_tree() -> void:
	pass


## Overrides Dialogue
func _ready() -> void:
	
	
	if OS.is_debug_build():
		$AnimationPlayer.seek(0)
	
	
	dialogue_label = $Base/V/Bottom/SceneText
	
	# NOTE/WARNING: THIS IS JANK
	pause_calculator = $PauseCalculator
	pause_timer = $PauseTimer
	blip = $DialogueBlip
	is_fully_visible = true
	message_speed = 15.0
	
	RenderingServer.set_default_clear_color(Color("#1f1f1f"))
	PaletteSwapper.set_palette(PaletteList.ATTIC)


func stop_text_scrolling() -> void:
	is_fully_visible = false


func resume_text_scrolling() -> void:
	is_fully_visible = true


func display_next_image() -> void:
	image_index += 1
	scene_image.texture = images[image_index]


func display_text_at_index(index: int) -> void:
	update_message(texts[index])


func clear_text() -> void:
	update_message("")


func show_image() -> void:
	scene_image.visible = true
	particles.emitting = false
	$Base/V/Top.visible = true
	$Base/V/Top/_PADDING.visible = true
	$Base/V/Bottom/SceneText.vertical_alignment = VerticalAlignment.VERTICAL_ALIGNMENT_TOP


func hide_image() -> void:
	scene_image.visible = false
	$Base/V/Top.visible = false
	$Base/V/Top/_PADDING.visible = false


func tween_to_brightness(new_brightness: float, duration: float) -> void:
	PaletteSwapper.tween_to_brightness(new_brightness, duration)


func initialize_final_image() -> void:
	scene_image.position.y -= 16


func move_image_down() -> void:
	for guy in $Base/V/Top/GUYS.get_children():
		if guy is TextureRect:
			guy.visible = false
	var tween = create_tween()
	tween.tween_property(scene_image, "position:y", scene_image.position.y + 16, 8.0)


func emit_particle_burst() -> void:
	particle_burst.emitting = true


func load_dialogue() -> void:
	hide_image()
	for guy in $Base/V/Top/GUYS.get_children():
		if guy is TextureRect:
			guy.visible = false
	clear_text()
	$DialogueManager.load_messages([
		"For years, I have listened to my", 
		"followers' prayers.",
		"They have begged me for judgment.",
		"For humanity to be cleansed.", 
		"For a perfect world with us in it.",
		"I, in my infinite patience, have obliged.",
		"I watched this world for centuries... judging...",
		"...assuming countless forms and witnessing humanity's atrocities.",
		"I have seen enough.",
		"Today, the day of reckoning has arrived,", 
		"and humanity shall be cleansed as my followers have requested.",
		"And so, I have assumed my final form...",
		"...Brioche."
	])


func _on_dialogue_manager_finished() -> void:
	## NOTE: Change scene happens here
	## This is just a placeholder fn
	get_tree().call_deferred("change_scene_to_packed", backyard_scene)
	
