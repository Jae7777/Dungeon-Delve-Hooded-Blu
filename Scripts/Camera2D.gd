extends Camera2D

var TargetNode: Node2D = null
# Called when the node enters the scene tree for the first time.
func _ready():
	TargetNode = $"../Player"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	set_position(TargetNode.get_position())
