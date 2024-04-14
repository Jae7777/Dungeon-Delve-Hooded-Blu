extends Area2D

var speed = 10
var direction = Vector2.ZERO
var is_in_attack_range = false
var damage = 10
@onready var target = $"../../Player"

func _process(delta):
	
	if is_in_attack_range:
		target.take_damage(damage)
		$Timers/DamageTimer.start()

func _physics_process(delta):
	position += direction * speed

func _on_area_2d_body_entered(body):
	is_in_attack_range = true
	
	
func _on_area_2d_body_exited(_body):
	is_in_attack_range = false
