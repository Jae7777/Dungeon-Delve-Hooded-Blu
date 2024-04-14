extends StaticBody2D


# Called when the node enters the scene tree for the first time.
var speed = 300
func _ready():
	constant_linear_velocity = Vector2(speed * cos(rotation), speed * sin(rotation))

func with_data(spawn_pos, target_dir):
	$animation_timer.start()
	position = Vector2(spawn_pos.x + 20, spawn_pos.y)
	look_at(target_dir)
	return self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_collide(constant_linear_velocity * delta)
