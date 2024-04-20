extends StaticBody2D

signal damage_taken()
signal attack()
signal on_death()
var target = null
var damage = 0
var can_attack = true
var speedup =preload("res://Scenes/SpeedUp.tscn")
var hpup =preload("res://Scenes/healthup.tscn")
var hp = preload("res://Scenes/heart_crystal.tscn")
var chest = preload("res://Scenes/chest.tscn")
var atkup = preload("res://Scenes/attackup.tscn")
var Fireball: PackedScene = preload("res://Scenes/fireball.tscn")

var health = Health.new().with_data(15)

func _ready():
	target = $"../../Player"

func with_data(_size):
	return self
	
func _process(_delta):
	if health.val() == 0:
		var drop = randf_range(0, 10)
		if(drop <= 1):
			var atkup1 = atkup.instantiate().with_data(position)
			$"../../Objects".add_child(atkup1)
		elif(drop <= 2):
			var hpup1 = hpup.instantiate().with_data(position)
			$"../../Objects".add_child(hpup1)
		elif(drop <= 3):
			var speedup1 = speedup.instantiate().with_data(position)
			$"../../Objects".add_child(speedup1)
		elif(drop <= 4):
			var hp1 = hp.instantiate().with_data(position)
			$"../../Objects".add_child(hp1)
		elif(drop <= 5):
			var chest1 = chest.instantiate().with_data(position)
			$"../../Objects".add_child(chest1)
			
		queue_free()
		
	if can_attack:
		can_attack = false
		attack.emit()
		$Timers/AttackTimer.start()
		
func take_damage(amount: int):
	health.reduce(amount)
	damage_taken.emit()

func _on_golem_animation_animation_finished():
	var fire = Fireball.instantiate()    
	$GolemAnimation/PKFire.play()
	add_child(fire)
	fire.direction = global_position.direction_to(target.global_position)
	fire.global_position = Vector2(global_position.x, global_position. y - 200)

func _on_attack_timer_timeout():
	can_attack = true
