extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var mouse_pos = get_viewport().get_mouse_position()
	var screen_center = get_viewport_rect().size / 2
	if (mouse_pos.x < screen_center.x):
		scale.x = abs(scale.x) * -1
	else:
		scale.x = abs(scale.x)
	
	if Input.is_action_pressed("MoveDown") or Input.is_action_pressed("MoveRight") or Input.is_action_pressed("MoveLeft") or Input.is_action_pressed("MoveUp"):
		play("Walk")
		$Walk_Sound.play()
	else:
		stop()
