extends CharacterBody2D
const MOVE_SPEED = 300
var move_direction = Vector2()
var target = null
var max_health = 10
var current_health = max_health

func _ready():
	target = $"../../Player"
	
func _physics_process(_delta):
	var target_position = target.get_position()
	velocity = (target_position - get_position()).normalized() * MOVE_SPEED
	set_velocity(velocity)
	move_and_slide()
	#print(current_health)

func take_damage(amount):
	current_health -= amount
	print(current_health)
	
