extends Node2D

var in_dialogue : bool

var bartender_dialogue : bool
var jim_sirloin_dialogue: bool
var criminal_dialogue : bool
var police_dialogue : bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func bartender():
	$CanvasLayer.visible = true
	$CanvasLayer/Character_Name.text = "Bartender"
	$CanvasLayer/speech.text = "Hello Johhny, what can I do for you?"
	$CanvasLayer/DialogueOption1.text = "Do you think I'll defeat Jim Sirloin?"
	$CanvasLayer/DialogueOption2.text = "Why are you still doing the competition?"
	$CanvasLayer/DialogueOption3.text = "How do you feel about ending?"
	$CanvasLayer/DialogueOption4.text = "Any rumers?"

func jim_sirloin():
	$CanvasLayer.visible = true
	$CanvasLayer/Character_Name.text = "Jim Sirloin"
	if SceneManager.competed_yet == false:
		$CanvasLayer/speech.text = "AH Johnny... come to lose?"
		$CanvasLayer/DialogueOption1.text = "let's begin (Begin competiton)"
		$CanvasLayer/DialogueOption2.text = "Why are you still doing the competition?"
		$CanvasLayer/DialogueOption3.text = "How do you feel about our relationship?"
		$CanvasLayer/DialogueOption4.text = "Do you have any regrets in life?"
	elif SceneManager.competed_yet:
		if SceneManager.player_won_comp:
			$CanvasLayer/speech.text = "You actually beat me... my god you did it... you finally did it..."
			$CanvasLayer/DialogueOption1.text = "You've never lost before, how does it feel?"
			$CanvasLayer/DialogueOption2.text = "What will you do now in your final moments?"
			$CanvasLayer/DialogueOption3.visible = false
			$CanvasLayer/DialogueOption4.visible = false
		elif SceneManager.jim_won_comp:
			$CanvasLayer/speech.text = "Well.... no changes there..."
			$CanvasLayer/DialogueOption1.text = "How do you always win?"
			$CanvasLayer/DialogueOption2.text = "What will you do now in your final moments?"
			$CanvasLayer/DialogueOption3.visible = false
			$CanvasLayer/DialogueOption4.visible = false

func criminal():
	$CanvasLayer.visible = true
	$CanvasLayer/Character_Name.text = "Criminal"
	$CanvasLayer/speech.text = "hey, you... can you help me out?"
	$CanvasLayer/DialogueOption1.text = "What's up?"
	$CanvasLayer/DialogueOption2.text = "Who are you?"
	$CanvasLayer/DialogueOption3.text = "Why are you in jail??"
	$CanvasLayer/DialogueOption4.visible = true

func policeman():
	$CanvasLayer.visible = true
	$CanvasLayer/Character_Name.text = "Policeman"
	$CanvasLayer/speech.text = "LWhat can I do for you?"
	$CanvasLayer/DialogueOption1.text = "Let the criminal out now! (fight)"
	$CanvasLayer/DialogueOption2.text = "Why is the criminal imprisoned?"
	$CanvasLayer/DialogueOption3.text = "The world is ending, can't you release him?"







func _on_dialogue_option_1_pressed() -> void:
	if bartender_dialogue:
		$CanvasLayer/speech.text = "I'll be honest mate... no, but that's fine! \nNo one can beat Jim Sirloin, he's the best
		competitor the world has ever seen. No one munches down on a steak like him! \nBUT don't let that discourage you. 
		He inspires you to be better, to be more, to push yourself beyond your limits"
	elif jim_sirloin_dialogue:
		if not SceneManager.competed_yet:
			get_tree().change_scene_to_file("res://Scenes/Levels/competition.tscn")
			bartender_dialogue = false
			jim_sirloin_dialogue = false
			$CanvasLayer.visible = false
			SceneManager.player_locked = false
		elif SceneManager.competed_yet:
			if SceneManager.player_won_comp:
				$CanvasLayer/speech.text = "Honestly... horrible.\nI've spent my whole life training to be the best in this. I sacrificed relationships, my own time, EVERYTHING.
				\nAnd now, in my final moments, I lose... my whole life has been a joke... \nfair play to you, you did well, but man..."
			elif SceneManager.jim_won_comp:
				$CanvasLayer/speech.text = "I sacrifice EVERYTHING Johnny... everything..."
	elif criminal_dialogue:
		$CanvasLayer/speech.text = "We're all about to die, and I don't want to die in here! Would you fight the policeman, knock him out, steal his keys, and let me out of here??"
	elif police_dialogue:
		get_tree().change_scene_to_file("res://Scenes/Levels/fightscene.tscn")
		police_dialogue = false
		$CanvasLayer.visible = false
		SceneManager.player_locked = false
		

func _on_dialogue_option_2_pressed() -> void:
	if bartender_dialogue:
		$CanvasLayer/speech.text = "Most people living on this island have lived here their whole life. We all know each other, we're all family, and if this is the end then we'll all come together to celebrate our lives. \n
		Afterall, who better to die with then your family?"
	elif jim_sirloin_dialogue:
		if not SceneManager.competed_yet:
			$CanvasLayer/speech.text = "Because what else is there to do? We're all about to die, if you hadn't noticed...
			\nI've spent my life being this island Steak Eating Champion, it's all I know. So if this is the end then I'll win one last time for the ride.
			\nI do apolgise if that was your goal too, but, like every single other year, you just won't win, no matter how hard you try..."
		elif SceneManager.competed_yet:
			if SceneManager.player_won_comp:
				$CanvasLayer/speech.text = "Probably grab a few drinks and watch the wave come in... I don't even know anymore... "
			elif SceneManager.jim_won_comp:
				$CanvasLayer/speech.text = "Grab a few drinks, look over my wall of victory, and then just chill. I've lived a life of winning, and now I'm gonna lose that life to something out of my control... the irony..."
	elif criminal_dialogue:
		$CanvasLayer/speech.text = "I'm Billy, came to the island recently for business, then got stranded when all the boats sank in the great Harbour Fire.... before you ask, no I didn't start it"
	elif police_dialogue:
		$CanvasLayer/speech.text = "This scum attacked Courtney in her shop. I won't allow that on my island."
func _on_dialogue_option_3_pressed() -> void:
	if bartender_dialogue:
		$CanvasLayer/speech.text = "I'm not overly thrilled to be doomed, and I don't suppose anyone is...
		\nbut I see this as an opportunity to appreciate the life we lived on this island we call home. This is our home, our place in the world.
		\nand I think we should celebrate that by gong out together. Happy, cheering, and with smiles."
	elif jim_sirloin_dialogue:
		$CanvasLayer/speech.text = "I've always respected you Johnny. You're the best out of the lot here. That loser Thomas never gave me much trouble, and William even less.
		\nYou're the only one who gave me a challenge. I train hard every year just to defeat you. You're no where near as good as me, but if I have a bad day then you'd have a chance.
		\nUnfortunately for you... I can't allow you to have that chance"
	elif criminal_dialogue:
		$CanvasLayer/speech.text = "Well... I don't plan on dying on this island, and I'd heard that Courtney had a liferaft that could POTENTIALLY get us off this doomed place. I confronted her about it, and we got into a little scuffle. The STUPID police officer then arrested me..."
	elif police_dialogue:
		$CanvasLayer/speech.text = "He broke the law! NO, of course not, Circumstances don't matter, he broke the law and will now pay for his crimes. If that leads to his death then so be it!"
func _on_dialogue_option_4_pressed() -> void:
	if bartender_dialogue:
		$CanvasLayer/speech.text = "Apparently PC Jones has arrested someone and is holding them in the prison next door. \n
		Unlucky fella really, PC Jones can be harsh, and to cause crimes at a time like this... well I guess his final moments will be painful"
	elif jim_sirloin_dialogue:
		$CanvasLayer/speech.text = "Well we're about to die so I might as well tell you, I wish I'd treated Courtney better. She'd come over and I'd spend all night training for the competiton.
		\nShe told me I was wasting my time, and now, in the face of death, I'm starting to believe her. If I could do that whole relationship over I'd defo focus on her more, even if it meant losing to you..."
	elif police_dialogue:
		$CanvasLayer/speech.text = "My whole life has been dedicated to keeping the residents of this island safe. As you know, I personally took down the Midnight Gang, but I can't help anyone now. I guess you can't beat nature..."
func _on_exit_pressed() -> void:
	bartender_dialogue = false
	jim_sirloin_dialogue = false
	criminal_dialogue = false
	police_dialogue = false
	$CanvasLayer.visible = false
	SceneManager.player_locked = false
