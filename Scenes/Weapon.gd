extends Node2D

var bodies_in_hitbox = {}
var damage = 5

func _process(_delta):
	if Input.is_action_just_pressed("PrimaryAction"):
		$"../Sword".play()
		for body in bodies_in_hitbox:
			if body.has_method("take_damage"):
				body.take_damage(damage)

func _on_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	bodies_in_hitbox[area] = null


func _on_area_shape_exited(_area_rid, area, _area_shape_index, _local_shape_index):
	bodies_in_hitbox.erase(area)


func _on_body_entered(body):
	bodies_in_hitbox[body] = null


func _on_body_exited(body):
	bodies_in_hitbox.erase(body)
