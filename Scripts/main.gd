extends Node2D

var player_by_steakhouse : bool
var player_by_police : bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_by_steakhouse:
		if Input.is_action_just_pressed("action"):
			get_tree().change_scene_to_file("res://Scenes/Levels/steakhouse.tscn")
	
	if player_by_police:
		if Input.is_action_just_pressed("action"):
			get_tree().change_scene_to_file("res://Scenes/Levels/police_station.tscn")


func _on_enter_steakhouse_area_body_entered(body: Node2D) -> void:
	if body is player:
		player_by_steakhouse = true
		SceneManager.show_interactive_prompt("Press E to enter Steakhouse")


func _on_enter_steakhouse_area_body_exited(body: Node2D) -> void:
	if body is player:
		player_by_steakhouse = false
		SceneManager.hide_interactive_prompt()


func _on_enter_police_station_body_entered(body: Node2D) -> void:
	if body is player:
		player_by_police = true
		SceneManager.show_interactive_prompt("Press E to enter Policestation")


func _on_enter_police_station_body_exited(body: Node2D) -> void:
	if body is player:
		player_by_police = false
		SceneManager.hide_interactive_prompt()
