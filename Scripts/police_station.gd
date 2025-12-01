extends Node2D

var player_in_area : bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_area:
		SceneManager.show_interactive_prompt("Press E to leave policestation")
		
		if Input.is_action_just_pressed("action"):
			get_tree().change_scene_to_file("res://Scenes/Levels/main.tscn")


func _on_leave_police_area_body_entered(body: Node2D) -> void:
	if body is player:
		player_in_area = true


func _on_leave_police_area_body_exited(body: Node2D) -> void:
	if body is player:
		player_in_area = false
		SceneManager.hide_interactive_prompt()
