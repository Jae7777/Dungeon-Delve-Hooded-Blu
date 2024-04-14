extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if $"..".target.position.x < position.x:
		scale.x = abs(scale.x) * -1
	else:
		scale.x = abs(scale.x)
	play("Float")
