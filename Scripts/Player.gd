extends CharacterBody2D
class_name Player

signal player_attack(area)
signal damage_taken()
signal healing()
signal player_death()
signal dash()
var dash_distance = 100
var SPEED = 400
var face_direction = Vector2()
var is_vulnerable
var windslash_scene = preload("res://windslash.tscn")

var health = Health.new().with_data(100)

var can_dash = true
var can_attack = true

func _ready():
	is_vulnerable = true
	
func _process(_delta):
	get_input(face_direction)
	set_velocity(velocity)
	move_and_slide()
	
	if Input.is_action_just_pressed("Dash") and can_dash:
		var mouse_pos = get_global_mouse_position()
		var direction = (mouse_pos - global_position).normalized()
		can_dash = false
		dash.emit()
		position +=  direction * dash_distance
		#position += get_global_mouse_position().normalized() * dash_distance
		$TImers/DashTimer.start()
		$PlayerAnimation/Dash.play()
	if Input.is_action_just_pressed("PrimaryAction") and can_attack:
		can_attack = false
		$TImers/AttackTimer.start()
		$PlayerAnimation/Sword.play()
		var windslash = windslash_scene.instantiate().with_data($PlayerAnimation/Marker2D.global_position, get_global_mouse_position(), $PlayerAnimation/Sword)
		$"../Projectiles".add_child(windslash)


func get_input(direction):
	direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	velocity = direction * SPEED
	return direction != Vector2.ZERO

func heal(amount: int):
	health.add(amount)
	healing.emit()

func take_damage(amount: int):
	$PlayerAnimation/OOF.play();
	health.reduce(amount)
	damage_taken.emit()
	if health.val() == 0:
		queue_free()
		get_tree().change_scene_to_file("res://game_death.tscn")

func _on_hit_timer_timeout():
	is_vulnerable = true
	
func _on_dash_timer_timeout():
	SPEED = 400
	can_dash = true

func _on_attack_timer_timeout():
	can_attack = true

func _on_dash_animation_timeout():
	pass # Replace with function body.
