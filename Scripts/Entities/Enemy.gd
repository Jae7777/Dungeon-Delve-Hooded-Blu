extends Node
class_name Enemy

var maxhp
var hp
var is_dead

func with_data(amt):
	maxhp = amt
	hp = amt
	return self
	
func _ready():
	is_dead = false

func take_damage(amt):
	hp -= amt
	hp = max(0, hp)
	if hp == 0:
		is_dead = true

func heal(amt):
	hp += amt
	hp = min(hp, maxhp)
