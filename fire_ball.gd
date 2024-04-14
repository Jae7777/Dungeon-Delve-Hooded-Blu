extends StaticBody2D


# Called when the node enters the scene tree for the first time.
var speed = 300
func _ready():
	constant_linear_velocity = Vector2(speed * cos(rotation), speed * sin(rotation))

func with_data(spawn_pos, target_dir):
	position = Vector2(spawn_pos.x + 20, spawn_pos.y)
	look_at(target_dir)
	return self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var body = move_and_collide(constant_linear_velocity * delta)
	if body != null:
		print(body.get_collider().has_method("take_damage"))
		if body.get_collider().has_method("take_damage"):
			body.get_collider().take_damage(10)
		queue_free()
