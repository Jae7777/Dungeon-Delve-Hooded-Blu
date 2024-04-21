extends HitBox2D

var bodies_in_hitbox = {}
var damage = 5

func _process(_delta):
	if Input.is_action_just_pressed("PrimaryAction"):
		$SwordAnimation.play()
		damage_all(damage)

