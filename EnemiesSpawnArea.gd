extends Node2D

var start
var player
var spawnRadius = 1000
var wave_size = 10
var enemies = [
	preload("res://Scenes/ghost_enemy.tscn"),
	preload("res://Scenes/fire_golem.tscn"),
	
]

var bosses = [
	preload("res://Scenes/Boss.tscn")
]

var object = [
	preload("res://Scenes/SpeedUp.tscn"), 
	preload("res://Scenes/Health_Up.tscn"), 
	preload("res://Scenes/Attack_up.tscn"), 
	preload("res://Scenes/heart_crystal.tscn"),
	preload("res://Scenes/chest.tscn")
]
var waves_defeated

func _ready():
	$"../Sountrack".play()
	player = $"../Player"
	waves_defeated = 0
	
func spawnObjects():
	var speedUp = object[1].instantiate()
	speedUp.position = Vector2(0, 0)
	add_child(speedUp)
	speedUp.position = Vector2(0, 128)
	add_child(speedUp)
	var pwrup = object[2].instantiate()
	pwrup.position = Vector2(128, 0)
	add_child(pwrup)
	var pwrup2 = object[3].instantiate()
	pwrup2.position = Vector2(-128, 0)
	add_child(pwrup2)
	var pwrup3 = object[3].instantiate()
	pwrup3.position = Vector2(0, 128)
	add_child(pwrup3)
	for i in range(wave_size):
		var _spawnPosition = calculateRandomSpawnPosition()
		var chest = object[0].instantiate()
		chest.position = Vector2(0 + (i * 64), 0 + (i *64))
		add_child(chest)	
			
	

	
func _process(_delta):
	if get_child_count() == 0:
		spawnEnemies()
		waves_defeated += 1
		$"../Sountrack".play()

func spawnEnemies():
	if waves_defeated % 2 == 1:
		$"../Boss Laugh".play()
		$"../BossMusic".play()
		var boss = bosses[0].instantiate()
		boss.max_health = waves_defeated * 240
		boss.position = Vector2(0, 0)
		add_child(boss)
		pass
		#increment waves defeated when boss ded
	else:
	
		for i in range(wave_size):
			var spawnPosition = calculateRandomSpawnPosition()
			var enemy = enemies[randi_range(0, enemies.size() - 1)].instantiate().with_data(randi_range(0, 2))
			enemy.position = spawnPosition
			add_child(enemy)

func calculateRandomSpawnPosition():
	var angle = randf_range(0, 2 * PI)
	var distance = randf_range(200, spawnRadius)
	var xOffset = distance * cos(angle)
	var yOffset = distance * sin(angle)
	var spawnPosition = player.position + Vector2(xOffset, yOffset)
	if (spawnPosition.x < -20 * 16 or spawnPosition.y > 50 * 16 or spawnPosition.x > 80 * 16 or spawnPosition.y < -20 * 16):
		spawnPosition = Vector2(randf_range(-128, 256), randf_range(-128, 256))
	return spawnPosition



func _on_timer_timeout():
	var start = true
