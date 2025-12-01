extends Control

var screen_count : int = 0

@export var screen_1 : CompressedTexture2D
@export var screen_2 : CompressedTexture2D
@export var screen_3 : CompressedTexture2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("advance"):
		screen_count += 1
	
	show_correct_screen()


func show_correct_screen():
	if screen_count == 0:
		$CanvasLayer/Background.texture = screen_1
		$CanvasLayer/Text.visible = true
		$CanvasLayer/Text2.visible = false
		$CanvasLayer/Text.text = "The Island Town is about to be struk by a tsunami... this is the end"
	elif screen_count == 2:
		$CanvasLayer/Background.texture = screen_2
		$CanvasLayer/Text.visible = false
		$CanvasLayer/Text2.visible = true
		$CanvasLayer/Text2.text = "Johnny Ribeye and Jim Sirloin have been in a fierce competition their entire lives... now, as the end approaches, they prepare to compete again!"
	elif screen_count == 3:
		$CanvasLayer/Background.texture = screen_3
		$CanvasLayer/Text2.text = "Developer here, I ran out of time so only finished 2 of the 6 minigames I had planned, the game will finish after both are complete and you will get a unique cutscene depending on outcomes"
		$CanvasLayer/Minigame1.visible = true
		$CanvasLayer/Minigame2.visible = true
	elif screen_count == 4:
		get_tree().change_scene_to_file("res://Scenes/Cutscenes/main_menu.tscn")


func _on_skip_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Cutscenes/main_menu.tscn")
