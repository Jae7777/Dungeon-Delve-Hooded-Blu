extends CharacterBody2D

signal player_attack(area)
signal damage_taken()
signal player_death()
var SPEED = 400
var face_direction = Vector2()
var is_vulnerable
var max_health = 100
var current_health = max_health

func _ready():
	is_vulnerable = true
	
func _process(_delta):
	get_input(face_direction)
	set_velocity(velocity)
	move_and_slide()
	print("curr health:" + str(current_health))

func get_input(direction):
	direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	velocity = direction * SPEED
	return direction != Vector2.ZERO

func heal(amount):
	current_health += amount
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
