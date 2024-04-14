extends CharacterBody2D

signal player_attack(area)
signal damage_taken()
signal healing()
signal player_death()
var dash_distance = 200
var SPEED = 400
var face_direction = Vector2()
var is_vulnerable
var max_health = 100
var current_health = max_health

var can_dash = true

func _ready():
	is_vulnerable = true
	
func _process(_delta):
	get_input(face_direction)
	set_velocity(velocity)
	move_and_slide()
	if Input.is_action_just_pressed("Dash") and can_dash:
		can_dash = false
		position += get_global_mouse_position().normalized() * dash_distance
		#position += get_global_mouse_position().normalized() * dash_distance
		$TImers/DashTimer.start()


func get_input(direction):
	direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	velocity = direction * SPEED
	return direction != Vector2.ZERO

func heal(amount):
	current_health += amount
	healing.emit()
	if current_health > max_health:
		current_health = max_health

func take_damage(amount):
	current_health -= amount
	damage_taken.emit()
	if current_health <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://game_death.tscn")

func _on_hit_timer_timeout():
	is_vulnerable = true
	
func _on_dash_timer_timeout():
	SPEED = 400
	can_dash = true
