extends StaticBody2D

const MOVE_SPEED = 150
signal damage_taken()
var move_direction = Vector2()
var target = null
var max_health = 80
var current_health = max_health
var damage = 10
var can_attack = true
var is_in_attack_range = false
var fireball_scene = preload ("res://Scenes/fireball.tscn")
var orb = preload("res://Scenes/BigFireBallProjectile.tscn")
var boss_ability_up = true



# Called when the node enters the scene tree for the first time.
func _ready():
	target = $"../../Player"
	can_attack = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var target_position = target.get_position()
	var velocity = (target_position - get_position()).normalized() * MOVE_SPEED
	position += velocity * delta
	if current_health <= 0:
		queue_free()
	
	if(boss_ability_up == true):
		var fireball = fireball_scene.instantiate()
		add_child(fireball)
		fireball.direction = global_position.direction_to(target_position)
		fireball.global_position = Vector2(global_position.x + 200, global_position. y - 100)
		var fireball2 = fireball_scene.instantiate()
		fireball2.direction = global_position.direction_to(target_position)
		fireball2.global_position = Vector2(global_position.x - 200, global_position. y - 100)
		
		$"Magic Cast".play()
		var fireorb = orb.instantiate()    
		add_child(fireorb)
		fireorb.direction = global_position.direction_to(target_position)
		fireorb.global_position = Vector2(global_position.x, global_position. y - 200)
		boss_ability_up = false
		$"Boss Ability Timer".start()
	
	if can_attack and is_in_attack_range:
		can_attack = false
		target.take_damage(damage)
		$Timers/DamageTimer.start()

func _on_attack_timer_timeout():
	can_attack = true

func take_damage(amount):
	current_health -= amount
	damage_taken.emit()
	

func _on_body_entered(_body):
	is_in_attack_range = true

func _on_body_exited(_body):
	is_in_attack_range = false


func _on_damage_timer_timeout():
	can_attack = true


func _on_boss_ability_timer_timeout():
	boss_ability_up = true


func _on_damage_taken():
	pass # Replace with function body.
