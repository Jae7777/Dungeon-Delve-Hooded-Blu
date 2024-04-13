extends CharacterBody2D

signal player_attack(area)
var SPEED = 400
var face_direction = Vector2()
var player_sprite = null

func _ready():
	player_sprite = $AnimatedSprite2D
	
func _physics_process(delta):
	get_input(face_direction)
	set_velocity(velocity)
	move_and_slide()
	#if Input.is_action_just_pressed("PrimaryAction"):
		#area_enter

func get_input(direction):
	direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	velocity = direction * SPEED
	return direction != Vector2.ZERO
