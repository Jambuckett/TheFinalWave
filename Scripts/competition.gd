extends Node2D

var rng = RandomNumberGenerator.new()
var random_num : int 

var jims_number : int

var number_below_5 : bool
var number_5 : bool
var number_above_5 : bool

var player_below_5 : bool
var player_5 : bool
var player_above_5 : bool

var jim_below_5 : bool
var jim_5: bool
var jim_above_5 : bool

var johnny_points : int
var jim_points : int

var johnny_win_round : bool
var jim_win_round : bool
var round_draw : bool

var johnny_win_game : bool
var jim_win_game : bool

var round_active : bool

var game_started : bool
var start_reveal_timer : bool



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_random_number()
	start_of_comp()
	$CanvasLayer/Next_round.text = "Start Competition"
	
	var bar = $CanvasLayer/NumHideBar
	bar.min_value = 0
	bar.max_value = $NumRevealTimer.wait_time
	bar.step = 0.01 
	bar.value = bar.max_value
	
	$CanvasLayer/Next_round.visible = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if start_reveal_timer:
		$CanvasLayer/NumHideBar.value = $NumRevealTimer.time_left
	
	$CanvasLayer/Number.text = str(random_num) 
	$CanvasLayer/Johnny_points.text = str(johnny_points)
	$CanvasLayer/Jim_points.text = str(jim_points)
	
	game_win()

func game_win():
	if johnny_points == 3:
		johnny_win_game = true
		SceneManager.player_won_comp = true
		$CanvasLayer/Next_round.text = "Return"
		SceneManager.competition_happened = true

	elif jim_points == 3:
		jim_win_game = true
		SceneManager.jim_won_comp = true
		$CanvasLayer/Next_round.text = "Return"
		SceneManager.competition_happened = true

	


func start_of_comp():
	remove_buttons()
	$CanvasLayer/Next_round.visible = true



func generate_random_number():
	rng.randomize()
	random_num = rng.randi_range(1,10)
	
	if random_num < 5:
		number_below_5 = true
	elif random_num == 5:
		number_5 = true
	elif random_num > 5:
		number_above_5 = true
	
	jims_number = rng.randi_range(1,10)
	print("Jims Number is : ", jims_number)
	
	if jims_number < 5:
		jim_below_5 = true
		$CanvasLayer/JimsNum.text = "Below 5"
	elif jims_number == 5:
		jim_5 = true
		$CanvasLayer/JimsNum.text = "Exact 5"
	elif jims_number > 5:
		jim_above_5 = true
		$CanvasLayer/JimsNum.text = "Above 5"
	
	
	print ("random number is :", random_num)


func restart():
	number_5 = false
	number_above_5 = false
	number_below_5 = false
	
	player_5 = false
	player_above_5 = false
	player_below_5 = false
	
	jim_5 = false
	jim_above_5 = false
	jim_below_5 = false
	
	$CanvasLayer/Below5.visible = true
	$CanvasLayer/Below5.disabled = false
	$CanvasLayer/Exact.visible = true
	$CanvasLayer/Exact.disabled = false
	$CanvasLayer/Above5.visible = true
	$CanvasLayer/Above5.disabled = false
	
	$CanvasLayer/Next_round.visible = false
	
	$CanvasLayer/NumHideBar.visible = true
	var bar = $CanvasLayer/NumHideBar
	bar.min_value = 0
	bar.max_value = $NumRevealTimer.wait_time
	bar.step = 0.01 
	bar.value = bar.max_value
	
	$CanvasLayer/JimsNum.visible = false
	$CanvasLayer/PlayerChoice.visible = false
	
	johnny_win_round = false
	jim_win_round = false
	round_draw = false
	
	$CanvasLayer/RoundWinner.visible = false
	
	generate_random_number()


func _on_num_reveal_timer_timeout() -> void:
	$CanvasLayer/NumHideBar.visible = false
	$CanvasLayer/Next_round.visible = true
	
	#$CanvasLayer/JimsNum.text = str(jims_number)
	$CanvasLayer/JimsNum.visible = true
	$CanvasLayer/RoundWinner.visible = true
	calculate_round_winner()


func remove_buttons():
	$CanvasLayer/Below5.visible = false
	$CanvasLayer/Below5.disabled = true
	$CanvasLayer/Exact.visible = false
	$CanvasLayer/Exact.disabled = true
	$CanvasLayer/Above5.visible = false
	$CanvasLayer/Above5.disabled = true



func _on_below_5_pressed() -> void:
	round_active = true
	player_below_5 = true
	remove_buttons()
	$NumRevealTimer.start()
	start_reveal_timer = true
	$CanvasLayer/PlayerChoice.visible = true
	$CanvasLayer/PlayerChoice.text = "Below 5"
	


func _on_exact_pressed() -> void:
	round_active = true
	player_5 = true
	remove_buttons()
	$NumRevealTimer.start()
	start_reveal_timer = true
	$CanvasLayer/PlayerChoice.visible = true
	$CanvasLayer/PlayerChoice.text = "Exact 5"


func _on_above_5_pressed() -> void:
	round_active = true
	player_above_5 = true
	remove_buttons()
	$NumRevealTimer.start()
	start_reveal_timer = true
	$CanvasLayer/PlayerChoice.visible = true
	$CanvasLayer/PlayerChoice.text = "Above 5"


func _on_next_round_pressed() -> void:
	restart()
	
	if not game_started:
		game_started = true

	
	if johnny_win_game or jim_win_game:
		get_tree().change_scene_to_file("res://Scenes/Levels/steakhouse.tscn")
		SceneManager.competed_yet = true
	
	


func calculate_round_winner():
	if number_below_5:
		if player_below_5 and not jim_below_5:
			johnny_win_round = true
		elif jim_below_5 and not player_below_5:
			jim_win_round = true
		else:
			round_draw = true
	elif number_5:
		if player_5 and not jim_5:
			johnny_win_round = true
		elif jim_5 and not player_5:
			jim_win_round = true
		else:
			round_draw = true
	elif number_above_5:
		if player_above_5 and not jim_above_5:
			johnny_win_round = true
		elif jim_above_5 and not player_above_5:
			jim_win_round = true
		else:
			round_draw = true
	
	if johnny_win_round:
		$CanvasLayer/RoundWinner.text = "Johnny has won round"
		johnny_points += 1
	elif jim_win_round:
		$CanvasLayer/RoundWinner.text = "Jim has won round"
		jim_points += 1
	elif round_draw:
		$CanvasLayer/RoundWinner.text = "Draw"
