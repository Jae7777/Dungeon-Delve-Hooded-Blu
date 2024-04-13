extends CharacterBody2D
const MOVE_SPEED = 300
var move_direction = Vector2()
var target = null

func _ready():
	target = $"../../Player"
	
func _physics_process(delta):
	var target_position = target.get_position()
	velocity = (target_position - get_position()).normalized() * MOVE_SPEED
	set_velocity(velocity)
	move_and_slide()
