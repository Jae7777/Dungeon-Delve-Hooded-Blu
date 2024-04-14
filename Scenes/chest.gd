extends StaticBody2D

signal damage_taken()
var max_health = 30
var current_health = max_health
var powerups = [
	preload("res://Scenes/Health_up.tscn")
]

func _process(_delta):
	if current_health <= 0:
		$AnimatedSprite2D.play("Break")
		var powerup = powerups[randi_range(0, powerups.size() - 1)].instantiate().with_data(position)
		$"../../Objects".add_child(powerup)
		queue_free()

func with_data(_pos):
	position = _pos
	return self

func take_damage(amount):
	$Crack.play()
	$AnimatedSprite2D.play("Hit")
	print('hit_')
	current_health -= amount
	damage_taken.emit()
	
