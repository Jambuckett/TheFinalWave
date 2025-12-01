extends Node2D

var player_locked : bool

var competed_yet : bool

var player_won_comp : bool
var jim_won_comp : bool

var fight_happened : bool = true

var player_won_fight : bool
var police_won_fight : bool

var competition_happened : bool = true




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$CanvasLayer.visible = false
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func show_interactive_prompt(text : String):
	$CanvasLayer/Instructions.visible = true
	$CanvasLayer/Instructions.text = text
	print ("prompt showing")

func hide_interactive_prompt():
	$CanvasLayer/Instructions.visible = false

func end_the_game():
	if fight_happened and competition_happened:
		print ("game over")
