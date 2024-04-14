extends Area2D

var heal_amount = 10

func _ready():
	pass
	
func with_data(pos):
	position = pos
	return self

func _on_body_entered(body):
	body.heal(heal_amount)
	queue_free()
