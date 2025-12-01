extends CharacterBody2D

var player_in_area : bool

var dialogue_count : int = 0

var dialogue_started : bool
var in_dialogue : bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_area and Input.is_action_just_pressed("action"):

		in_dialogue = true
		SceneManager.player_locked = true
		DialogueManager.bartender_dialogue = true
		DialogueManager.bartender()
		#if Input.is_action_just_pressed("advance"):
			#dialogue_count += 1
			#print (dialogue_count)
			#dialogue()
	#

func dialogue():
	$DialogueBox.visible = true

	
	if dialogue_count == 0:
		$DialogueBox/Option1.visible = false
		$DialogueBox/Option2.visible = false
	elif dialogue_count == 1:
		$DialogueBox/Speech.visible = false
		$DialogueBox/Option1.visible = true
		$DialogueBox/Option1.text = "Why are you still running the competition if we're all about to die?"
		$DialogueBox/Option2.visible = true
		$DialogueBox/Option2.text = "Do you think I will beat Jim Sirloin this year?"
	elif dialogue_count == 3:
		$DialogueBox/Speech.text = "Speak to John Sirloin when you're ready to compete"
	elif dialogue_count == 4:
		$DialogueBox.visible = false
		in_dialogue = false

func _on_player_detect_area_body_entered(body: Node2D) -> void:
	if body is player:
		player_in_area = true
		SceneManager.show_interactive_prompt("Press E to talk to Bartender")


func _on_player_detect_area_body_exited(body: Node2D) -> void:
	if body is player:
		player_in_area = false
		SceneManager.hide_interactive_prompt()
		$DialogueBox.visible = false


func _on_option_1_pressed() -> void:
	dialogue_count += 1
	$DialogueBox/Option1.visible = false
	$DialogueBox/Option2.visible = false
	$DialogueBox/Speech.visible = true
	$DialogueBox/Speech.text = "We may be about to die, but this'll bring everyone together before the end"


func _on_option_2_pressed() -> void:
	dialogue_count += 1
	$DialogueBox/Option1.visible = false
	$DialogueBox/Option2.visible = false
	$DialogueBox/Speech.visible = true
	$DialogueBox/Speech.text = "I'll be honest... no... but don't let that haunt you. No one can beat Jim Sirloin"
