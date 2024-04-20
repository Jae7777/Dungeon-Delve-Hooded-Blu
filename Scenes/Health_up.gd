extends Area2D

var is_in_attack_range = false
var target

func _ready():
	target = $"../../Player"

func with_data(pos):
	position = pos
	return self
	
func _process(_delta):
	if is_in_attack_range:
		target.health.change_max(target.health.max_val() + 10)
		queue_free()


func _on_body_entered(_body):
	is_in_attack_range = true

