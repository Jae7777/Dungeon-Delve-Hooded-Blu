extends StaticBody2D

signal damage_taken()
signal attack()
signal on_death()
var target = null
var max_health = 15
var current_health = max_health
var damage = 0
var can_attack = true
var heart_crystal_scene: PackedScene = preload("res://Scenes/heart_crystal.tscn")
var Fireball: PackedScene = preload("res://Scenes/Fireball.tscn")

func _ready():
	target = $"../../Player"

func with_data(_size):
	return self
	
func _process(delta):
	if current_health <= 0:
		var heart_crystal = heart_crystal_scene.instantiate().with_data(position)
		$"../../Objects".add_child(heart_crystal)
		queue_free()
		
	if can_attack:
		can_attack = false
		attack.emit()
		$Timers/AttackTimer.start()
		
func take_damage(amount):
	current_health -= amount
	damage_taken.emit()

func _on_golem_animation_animation_finished():
	var fire = Fireball.instantiate()	
	add_child(fire)
	fire.direction = global_position.direction_to(target.global_position)
	fire.global_position = global_position

func _on_attack_timer_timeout():
	can_attack = true
