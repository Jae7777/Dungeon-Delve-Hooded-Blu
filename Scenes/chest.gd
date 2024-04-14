extends StaticBody2D

signal damage_taken()
var max_health = 30
var current_health = max_health
var powerup = preload("res://Scenes/Attack_up.tscn")

func _process(delta):
	if current_health <= 0:
		$AnimatedSprite2D.play("Break")
		var atkup = powerup.instantiate().with_data(position)
		$"../../Objects".add_child(atkup)
		queue_free()

func with_data(pos):
	return self

func take_damage(amount):
	$Crack.play()
	$AnimatedSprite2D.play("Hit")
	print('hit_')
	current_health -= amount
	damage_taken.emit()
	
