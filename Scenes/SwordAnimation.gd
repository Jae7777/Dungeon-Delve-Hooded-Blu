extends AnimatedSprite2D
var can_attack = true
var animation_timer = null

func _ready():
	can_attack = true
	
func _process(_delta):
	if Input.is_action_just_pressed("PrimaryAction") and can_attack:
		$"../../../TImers/AttackTimer".start()
		can_attack = false
		play("Swing")

func _on_timer_timeout():
	can_attack = true
	stop()
