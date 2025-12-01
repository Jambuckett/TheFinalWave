extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	show_correct_buttons()

func show_correct_buttons():
	if SceneManager.competition_happened:
		$CanvasLayer/Steakhouse.visible = false
	elif not SceneManager.competed_yet:
		$CanvasLayer/Steakhouse.visible = true

func _on_steakhouse_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/steakhouse.tscn")


func _on_endgame_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Cutscenes/onbeachending.tscn")
