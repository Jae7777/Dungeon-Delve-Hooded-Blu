extends StaticBody2D

signal damage_taken()
signal attack()
signal on_death()
var target = null
var max_health = 15
var current_health = max_health
var damage = 0
var can_attack = true
var speedup =preload("res://Scenes/SpeedUp.tscn")
var hpup =preload("res://Scenes/Health_Up.tscn")
var hp = preload("res://Scenes/heart_crystal.tscn")
var chest = preload("res://Scenes/chest.tscn")
var atkup = preload("res://Scenes/Attack_up.tscn")
var Fireball: PackedScene = preload("res://Scenes/Fireball.tscn")

func _ready():
	target = $"../../Player"

func with_data(_size):
	return self
	
func _process(_delta):
	if current_health <= 0:
		var drop = randf_range(0, 10)
		if(drop <= 1):
			var atkup1 = atkup.instantiate().with_data(position)
			$"../../Objects".add_child(atkup1)
		elif(drop <= 2):
			var hpup = hpup.instantiate().with_data(position)
			$"../../Objects".add_child(hpup)
		elif(drop <= 3):
			var speedup = speedup.instantiate().with_data(position)
			$"../../Objects".add_child(speedup)
		elif(drop <= 4):
			var hp = hp.instantiate().with_data(position)
			$"../../Objects".add_child(hp)
		elif(drop <= 5):
			var chest = chest.instantiate().with_data(position)
			$"../../Objects".add_child(chest)
			
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
	$GolemAnimation/PKFire.play()
	add_child(fire)
	fire.direction = global_position.direction_to(target.global_position)
	fire.global_position = Vector2(global_position.x, global_position. y - 200)

func _on_attack_timer_timeout():
	can_attack = true
