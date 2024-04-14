extends Area2D

var speed = 10
var direction = Vector2.ZERO
var is_in_attack_range = false
var damage = 10
var target

func _ready():
	target = $"../../../Player"

func _process(delta):
	
	if is_in_attack_range:
		target.take_damage(damage)
	$Timer.start()
		

func _physics_process(delta):
	position += direction * speed


func _on_timer_timeout():
	queue_free()


func _on_body_entered(_body):
	is_in_attack_range = true


func _on_body_exited(_body):
	is_in_attack_range = false
