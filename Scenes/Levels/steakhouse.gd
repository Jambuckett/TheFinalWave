extends Node2D

var player_in_area : bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_area:
		if Input.is_action_just_pressed("action"):
			if not SceneManager.fight_happened and SceneManager.competition_happened:
				get_tree().change_scene_to_file("res://Scenes/Levels/main.tscn")
			elif SceneManager.fight_happened and SceneManager.competition_happened:
				SceneManager.show_interactive_prompt("Press E to end game")
				get_tree().change_scene_to_file("res://Scenes/Cutscenes/onbeachending.tscn")


func _on_leave_area_body_entered(body: Node2D) -> void:
	if body is player:
		player_in_area = true
		SceneManager.show_interactive_prompt("Press E to leave Steakhouse")



func _on_leave_area_body_exited(body: Node2D) -> void:
	if body is player:
		player_in_area = false
		SceneManager.hide_interactive_prompt()
