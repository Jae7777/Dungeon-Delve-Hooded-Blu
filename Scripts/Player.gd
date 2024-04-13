extends CharacterBody2D

signal player_attack(area)
var SPEED = 400
var face_direction = Vector2()
var is_vulnerable
var max_health = 10
var health = max_health

func _ready():
	is_vulnerable = true
	
func _process(_delta):
	get_input(face_direction)
	set_velocity(velocity)
	move_and_slide()

func get_input(direction):
	direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	velocity = direction * SPEED
	return direction != Vector2.ZERO

func hit():
	if is_vulnerable:
		health -= 10
	if health <= 0:
		queue_free()

func _on_hit_timer_timeout():
	is_vulnerable = true
