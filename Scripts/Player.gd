extends CharacterBody2D


var SPEED = 400


func _process(delta):
	get_input()
	set_velocity(velocity)
	move_and_slide()
	
	
func get_input():
	var direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	velocity = direction * SPEED
