extends CharacterBody2D
class_name player

@export var move_speed = 100




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move()
	move_and_slide()


func move():
	if SceneManager.player_locked:
		return
	
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = direction * move_speed
	
	if velocity.y > 0:
		$AnimatedSprite2D.play("walk_down")
	elif velocity.y < 0:
		$AnimatedSprite2D.play("walk_up")
	elif velocity.x > 0:
		$AnimatedSprite2D.play("walk_right")
	elif velocity.x < 0:
		$AnimatedSprite2D.play("walk_left")
	elif velocity == Vector2.ZERO:
		$AnimatedSprite2D.stop()
