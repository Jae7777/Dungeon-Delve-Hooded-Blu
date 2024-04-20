extends ProgressBar

@export var target: Node2D

func _ready():
	max_value = target.health.val()
	set_health_bar()
	
func set_health_bar():
	value = target.health.val()

func _on_player_damage_taken():
	set_health_bar()

func _on_ghost_enemy_damage_taken():
	set_health_bar()

func _on_player_healing():
	set_health_bar()

func _on_fire_golem_damage_taken():
	set_health_bar()


func _on_boss_damage_taken():
	set_health_bar()
