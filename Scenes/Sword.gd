extends Node2D

var damage_amount = 10
var face_direction

# Called when the node enters the scene tree for the first time.
func _ready():
	look_at(get_global_mouse_position())
	print("spawned")
	
func with_data(spawn_pos):
	position = spawn_pos
	return self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_hitbox_body_entered(body):
	if body.has_method("deal_damage"):
		body.take_damage(damage_amount)
		
