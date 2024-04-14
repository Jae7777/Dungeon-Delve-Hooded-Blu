extends CharacterBody2D
const MOVE_SPEED = 300
var move_direction = Vector2()
var target = null
var max_health = 30
var current_health = max_health
var heart_crystal_scene: PackedScene = preload("res://Scenes/heart_crystal.tscn")

func _ready():
	target = $"../../Player"

func with_data(size):
	match size:
		0:
			current_health = 10
			scale = Vector2(0.33, 0.33)
		1:
			current_health = 20
			scale =  Vector2(0.66, 0.66)
		2:
			current_health = 30
			scale =  Vector2(1, 1)
		_:
			current_health = 20
	return self
	
func _physics_process(_delta):
	var target_position = target.get_position()
	velocity = (target_position - get_position()).normalized() * MOVE_SPEED
	set_velocity(velocity)
	move_and_slide()
	if current_health <= 0:
		var heart_crystal = heart_crystal_scene.instantiate().with_data(position)
		$"../../Objects".add_child(heart_crystal)
		queue_free()

func take_damage(amount):
	current_health -= amount
	print(current_health)
	
