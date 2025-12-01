extends Node2D

var rng = RandomNumberGenerator.new()
var random_num : int 

var player_health : int
var player_max_health : int = 30
var enemy_health : int
var enemy_max_health : int = 30

var player_punch_damage : int = 10
var enemy_punch_damage : int


var enemy_charging : bool
var enemy_charging_1 : bool
var enemy_charging_2 : bool
var enemy_has_charge : bool
var enemy_punch : bool
var enemy_block : bool
var enemy_charge_count : int = 0

var player_charging : bool
var player_charging_1 : bool
var player_charging_2 : bool
var player_punch : bool
var player_block : bool
var player_charge_count : int = 0


var game_started : bool
var game_won : bool

var player_won : bool
var enemy_won : bool

var start_timer : bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_fight()

	var bar = $CanvasLayer/NumHideBar
	bar.min_value = 0
	bar.max_value = $RoundsTimer.wait_time
	bar.step = 0.01 
	bar.value = bar.max_value
	
	player_health = player_max_health
	enemy_health = enemy_max_health

	# set up health bars
	var enemy_bar = $CanvasLayer/EnemyHealthBar
	enemy_bar.min_value = 0
	enemy_bar.max_value = enemy_max_health
	enemy_bar.value = enemy_health

	var player_bar = $CanvasLayer/PlayerHealthBar
	player_bar.min_value = 0
	player_bar.max_value = player_max_health
	player_bar.value = player_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if start_timer:
		$CanvasLayer/NumHideBar.value = $RoundsTimer.time_left
	
	fight_over()

func update_enemy_health_bar():
	$CanvasLayer/EnemyHealthBar.value = enemy_health

func update_player_health_bar():
	$CanvasLayer/PlayerHealthBar.value = player_health


func start_fight():
	$CanvasLayer/PoliceMove.visible = false
	remove_buttons()

func remove_buttons():
	$CanvasLayer/Charge.visible = false
	$CanvasLayer/Punch.visible = false
	$CanvasLayer/Block.visible = false

func fight_over():
	if player_health <= 0:
		$CanvasLayer/StartButton.text = "Return"
		enemy_won = true
		$CanvasLayer/WhoHasWon.visible = true
		$CanvasLayer/WhoHasWon.text = "Police has won"
	elif enemy_health <= 0:
		$CanvasLayer/StartButton.text = "Return"
		player_won = true
		$CanvasLayer/WhoHasWon.visible = true
		$CanvasLayer/WhoHasWon.text = "Johnny has won"



func _on_start_button_pressed() -> void:
	if player_won:
		SceneManager.fight_happened = true
		get_tree().change_scene_to_file("res://Scenes/Cutscenes/release_prisoner.tscn")
	elif enemy_won:
		SceneManager.fight_happened = true
		get_tree().change_scene_to_file("res://Scenes/Cutscenes/behind_bars_ending.tscn")
	else:
		next_round()


func _on_charge_pressed() -> void:
	if player_charge_count == 0:
		player_charge_count += 1
		player_charging = true
		print ("player charged count == 1")
		remove_buttons()
		$RoundsTimer.start()
		start_timer = true
	elif player_charge_count == 1:
		player_charge_count += 1
		print ("player charged count == 2")
		player_charging = false
		player_charging_1 = true
		remove_buttons()
		$RoundsTimer.start()
		start_timer = true
	elif player_charge_count == 2:
		player_charge_count += 1
		print ("player charged count == 3")
		player_charging = false
		player_charging_1 = false
		player_charging_2 = true
		start_timer = true
		$CanvasLayer/Charge.visible = false
		
		remove_buttons()
		$RoundsTimer.start()


func _on_punch_pressed() -> void:
	player_punch = true
	player_block = false
	$RoundsTimer.start()
	remove_buttons()
	start_timer = true


func _on_block_pressed() -> void:
	player_block = true
	player_punch = false
	$RoundsTimer.start()
	remove_buttons()
	start_timer = true

func opponentt_move():
	rng.randomize()
	random_num = rng.randi_range(0,10)
	

	enemy_charging = false
	enemy_block = false
	enemy_punch = false
	
	if random_num < 4:
		enemy_charging = true
		enemy_has_charge = true
		enemy_charge_count += 1
		if enemy_charge_count < 3:
			enemy_charge_count += 1


	elif random_num < 9:
		if enemy_has_charge:
			enemy_punch = true
			enemy_has_charge = false
		else:
			enemy_block = true


	else:
		enemy_block = true
		
	print("opponent number: ", random_num, " | charge_count: ", enemy_charge_count,
		" | charging: ", enemy_charging, " | punch: ", enemy_punch, " | block: ", enemy_block)



func _on_rounds_timer_timeout() -> void:
	start_timer = false
	$CanvasLayer/NumHideBar.visible = false
	$CanvasLayer/StartButton.visible = true
	$CanvasLayer/StartButton.text = "Next Round"
	
	if player_charging:
		$Fighter_player/AnimatedSprite2D.play("charge")
		print ("Enemy health: ", enemy_health)
	elif player_charging_1:
		$Fighter_player/AnimatedSprite2D.play("charge_1")
		print ("Enemy health: ", enemy_health)
	elif player_charging_2:
		$Fighter_player/AnimatedSprite2D.play("charge_2")
		print ("Enemy health: ", enemy_health)
	
	## calculate punch damage ## 
	
	if player_charge_count == 1:
		player_punch_damage = 5
	elif player_charge_count == 2:
		player_punch_damage = 8
	elif player_charge_count == 3:
		player_punch_damage = 12
	
	if enemy_charge_count == 1:
		enemy_punch_damage = 5
	elif enemy_charge_count == 2:
		enemy_punch_damage = 8
	elif enemy_charge_count == 3:
		enemy_punch_damage = 12
	
	
	if player_punch:
		$Fighter_player/AnimatedSprite2D.play("punch")
		#$Fighter_player/AnimatedSprite2D.play("idle")
		if not enemy_block:
			enemy_health -= player_punch_damage
			update_enemy_health_bar()
			print ("enenmy took, ", player_punch_damage, " and is at health : ", enemy_health)
		elif enemy_block:
			enemy_health -= 0


		player_charge_count = 0
		player_charging = false
		player_charging_1 = false
		player_charging_2 = false
		player_punch = false
	
	elif  player_block:
		$Fighter_player/AnimatedSprite2D.play("block")
	
	# ENEMY MOVES #
	
	if enemy_charging:
		$CanvasLayer/PoliceMove.visible = true
		$CanvasLayer/PoliceMove.text = "Charging"
		if enemy_charge_count == 1:
			$Fighter_police/AnimatedSprite2D.play("charge")
			enemy_punch_damage = 5
		elif enemy_charge_count == 2:
			$Fighter_police/AnimatedSprite2D.play("charge_1")
			enemy_punch_damage = 8
		elif enemy_charge_count == 3:
			$Fighter_police/AnimatedSprite2D.play("charge_2")
			enemy_punch_damage = 12
	
	if enemy_punch:
		$CanvasLayer/PoliceMove.visible = true
		$CanvasLayer/PoliceMove.text = "Punch!"
		$Fighter_police/AnimatedSprite2D.play("punch")
		
		if enemy_punch and not player_block:
			player_health -= enemy_punch_damage
			update_player_health_bar()
			print ("Player took, ", enemy_punch_damage, " player health now at  : ",player_health )
		elif enemy_punch and player_block:
			player_health -= 0
		
		enemy_charge_count = 0
		enemy_charging_1 = false
		enemy_charging = false
		enemy_charging_2 = false
		enemy_punch = false
	
	if enemy_block:
		$Fighter_police/AnimatedSprite2D.play("block")
		$CanvasLayer/PoliceMove.visible = true
		$CanvasLayer/PoliceMove.text = "Block!"

	# HEALTH #
	
	#if player_punch:
		##$Fighter_player/AnimatedSprite2D.play("idle")
		#player_punch = false
		#if player_punch and not enemy_block:
			#enemy_health -= player_punch_damage
			#print ("enemy took, ", player_punch_damage, " enemy health now at  : ",enemy_health )
		#elif player_punch and enemy_block:
			#enemy_health -= 0
	#elif player_block:
		#$Fighter_player/AnimatedSprite2D.play("block")
		#player_block = false


func next_round():
	opponentt_move()

	$CanvasLayer/PoliceMove.visible = false
	$CanvasLayer/StartButton.visible = false
	if player_charge_count != 3:
		$CanvasLayer/Charge.visible = true
	elif player_charge_count == 3:
		$CanvasLayer/Charge.visible = false
	
	if player_charge_count > 0:
		$CanvasLayer/Punch.visible = true
	
	#if not player_charging:
		#$CanvasLayer/Punch.visible = false
	#elif player_charging or player_charging_1 or player_charging_2:
		#$CanvasLayer/Punch.visible = true
	$CanvasLayer/Block.visible = true
	
	if player_charge_count == 0:
		$Fighter_player/AnimatedSprite2D.play("idle")
	elif player_charge_count == 1:
		$Fighter_player/AnimatedSprite2D.play("charge")
	elif player_charge_count == 2:
		$Fighter_player/AnimatedSprite2D.play("charge_1")
	elif player_charge_count == 3:
		$Fighter_player/AnimatedSprite2D.play("charge_2")
	
	if enemy_charge_count == 0:
		$Fighter_police/AnimatedSprite2D.play("idle")
	elif enemy_charge_count == 1:
		$Fighter_police/AnimatedSprite2D.play("charge")
	elif enemy_charge_count == 2:
		$Fighter_police/AnimatedSprite2D.play("charge_1")
	elif enemy_charge_count == 3:
		$Fighter_police/AnimatedSprite2D.play("charge_2")
	
	$CanvasLayer/NumHideBar.visible = true
	var bar = $CanvasLayer/NumHideBar
	bar.min_value = 0
	bar.max_value = $RoundsTimer.wait_time
	bar.step = 0.01 
	bar.value = bar.max_value
	
	#if enemy_punch:
		#$Fighter_police/AnimatedSprite2D.play("idle")
	#if enemy_block:
		#$Fighter_police/AnimatedSprite2D.play("idle")
