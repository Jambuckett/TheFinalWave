extends CharacterBody2D

var player_in_area : bool




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_area and Input.is_action_just_pressed("action"):

		SceneManager.player_locked = true
		DialogueManager.criminal_dialogue = true
		DialogueManager.criminal()


func _on_player_detect_area_body_entered(body: Node2D) -> void:
	if body is player:
		player_in_area = true
		SceneManager.show_interactive_prompt("Press E to speak to Criminal")


func _on_player_detect_area_body_exited(body: Node2D) -> void:
	if body is player:
		player_in_area = false
		SceneManager.hide_interactive_prompt()
