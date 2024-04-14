extends Area2D

var speed = 10
var direction = Vector2.ZERO
# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	position += direction * speed
