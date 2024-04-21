extends Area2D
class_name HitBox2D

var _bodies_in_hitbox = {}

func _ready():
	pass

func damage_all(amt: int):
	for body in _bodies_in_hitbox:
		if body == null:
			_bodies_in_hitbox.erase(body)
		elif body.has_method("take_damage"):
			body.take_damage(amt)

func _on_body_entered(body):
	_bodies_in_hitbox[body] = null

func _on_body_exited(body):
	_bodies_in_hitbox.erase(body)
