extends Node2D

var bodies_in_hitbox = {}
var damage = 10

func _process(_delta):
	if Input.is_action_just_pressed("PrimaryAction"):
		for body in bodies_in_hitbox:
			if body.has_method("take_damage"):
				body.take_damage(damage)
				print(body)

func _on_hitbox_body_entered(body):
	bodies_in_hitbox[body] = null


func _on_hitbox_body_exited(body):
	bodies_in_hitbox.erase(body)
