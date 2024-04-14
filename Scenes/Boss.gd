extends StaticBody2D

const MOVE_SPEED = 300
var move_direction = Vector2()
var target = null
var max_health = 400
var current_health = max_health
var damage = 10
var can_attack = true
var is_in_attack_range = false
var fireball_scene = preload ("res://Scenes/fireball.tscn")
var orb = preload("res://Scenes/BigFireBallProjectile.tscn")



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
		
	var orb = orb.instantiate()    
	orb.global_position = Vector2(global_position.x, global_position. y - 200)
	orb.direction = (orb.position - target.position).normalized()
	add_child(orb)
	
	if can_attack and is_in_attack_range:
		can_attack = false
		target.take_damage(damage)
		$Timers/DamageTimer.start()

func _on_attack_timer_timeout():
	can_attack = true


func _on_body_entered(_body):
	is_in_attack_range = true

func _on_body_exited(_body):
	is_in_attack_range = false


func _on_damage_timer_timeout():
	can_attack = true
