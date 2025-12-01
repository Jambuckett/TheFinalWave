extends CharacterBody2D


var player_in_area : bool

var dialogue_count : int = 0

var dialogue_started : bool
var in_dialogue : bool



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DialogueBox.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_area and Input.is_action_just_pressed("action"):

		in_dialogue = true
		SceneManager.player_locked = true
		DialogueManager.jim_sirloin_dialogue = true
		DialogueManager.jim_sirloin()
	#if in_dialogue and Input.is_action_just_pressed("advance"):
		#dialogue_count += 1
		#print (dialogue_count)
		#dialogue()
	

func dialogue():
	$DialogueBox.visible = true
	$DialogueBox/CharacterName.text = "Jim Sirloin"

	
	if dialogue_count == 0:
		$DialogueBox/Option1.visible = false
		$DialogueBox/Option2.visible = false
		$DialogueBox/Speech.text = "Ready to lose to me one last time?"
	elif dialogue_count == 1:
		$DialogueBox/Speech.visible = false
		$DialogueBox/Option1.visible = true
		$DialogueBox/Option1.text = "I will beat you, I have nothing left to lose..."
		$DialogueBox/Option2.visible = true
		$DialogueBox/Option2.text = "You really want to do this as the worlds ending?"
	elif dialogue_count == 3:
		$DialogueBox/Speech.text = "Speak to John Sirloin when you're ready to compete"
	elif dialogue_count == 4:
		$DialogueBox.visible = false
		in_dialogue = false

func _on_player_detect_area_body_entered(body: Node2D) -> void:
	if body is player:
		player_in_area = true
		SceneManager.show_interactive_prompt("Press E to talk to Jim Sirloin")


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
	$DialogueBox/Speech.text = "Oh it's on"


func _on_option_2_pressed() -> void:
	dialogue_count += 1
	$DialogueBox/Option1.visible = false
	$DialogueBox/Option2.visible = false
	$DialogueBox/Speech.visible = true
	$DialogueBox/Speech.text = "Got somewhere else to be? If I'm gonna die then I'm dying a champion"
