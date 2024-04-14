extends Area2D

signal damage_taken()
signal on_death()
var target = null
var max_health = 15
var current_health = max_health
var damage = 0
var can_attack
var heart_crystal_scene: PackedScene = preload("res://Scenes/heart_crystal.tscn")

func _ready():
	target = $"../../Player"

func with_data(size):
	match size:
		0:
			current_health = 10
			scale = Vector2(2, 2)
		1:
			current_health = 20
			scale =  Vector2(1.5, 1.5)
		2:
			current_health = 30
			scale =  Vector2(1, 1)
		_:
			current_health = 20
	return self
	
func _process(delta):
	if current_health <= 0:
		var heart_crystal = heart_crystal_scene.instantiate().with_data(position)
		$"../../Objects".add_child(heart_crystal)
		queue_free()
		
	if can_attack:
		can_attack = false
		target.take_damage(damage)
		$Timers/DamageTimer.start()

func take_damage(amount):
	current_health -= amount
	damage_taken.emit()
	print(current_health)
	


func _on_damage_timer_timeout():
	can_attack = true


func _on_timer_timeout():
	pass # Replace with function body.
