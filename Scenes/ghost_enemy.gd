extends StaticBody2D
signal damage_taken()
signal on_death()
const MOVE_SPEED = 300
var move_direction = Vector2()
var target = null
var damage = 5
var can_attack = true
var speedup =preload("res://Scenes/SpeedUp.tscn")
var hpup =preload("res://Scenes/healthup.tscn")
var hp = preload("res://Scenes/heart_crystal.tscn")
var chest = preload("res://Scenes/chest.tscn")
var atkup = preload("res://Scenes/attackup.tscn")
var is_in_attack_range = false

var health

func _ready():
	target = $"../../Player"
	can_attack = true

func with_data(size):
	match size:
		0:
			health = Health.new().with_data(10)
			scale = Vector2(0.33, 0.33)
		1:
			health = Health.new().with_data(20)
			scale =  Vector2(0.66, 0.66)
		2:
			health = Health.new().with_data(30)
			scale =  Vector2(1, 1)
		_:
			health = Health.new().with_data(20)
	return self
	
func _process(delta):
	var target_position = target.get_position()
	var velocity = (target_position - get_position()).normalized() * MOVE_SPEED
	position += velocity * delta
	if health.val() <= 0:
		var drop = randf_range(0, 10)
		if(drop <= 1):
			var atkup1 = atkup.instantiate().with_data(position)
			$"../../Objects".add_child(atkup1)
		elif(drop <= 2):
			var hpup1 = hpup.instantiate().with_data(position)
			$"../../Objects".add_child(hpup1 )
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
	
	if can_attack and is_in_attack_range:
		can_attack = false
		target.take_damage(damage)
		$Timers/DamageTimer.start()

func take_damage(amount: int):
	health.reduce(amount)
	damage_taken.emit()
	

func _on_body_entered(_body):
	is_in_attack_range = true

func _on_body_exited(_body):
	is_in_attack_range = false


func _on_damage_timer_timeout():
	can_attack = true
