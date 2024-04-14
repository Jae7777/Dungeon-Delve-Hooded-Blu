extends Node2D


var player
var spawnRadius = 1000
var wave_size = 10
var enemies = [
	preload("res://Scenes/ghost_enemy.tscn"),
	preload("res://Scenes/fire_golem.tscn"),
	preload("res://Scenes/chest.tscn")
]
var bosses = [
	preload("res://Scenes/Boss.tscn")
]
var waves_defeated

func _ready():
	$"../Sountrack".play()
	player = $"../Player"
	spawnEnemies()
	waves_defeated = 0

	
func _process(_delta):
	if get_child_count() == 0:
		spawnEnemies()
		waves_defeated += 1
	if waves_defeated == 1:
		$"../Sountrack".stop()

func spawnEnemies():
	if waves_defeated == 1:
		$"../BossMusic".play()
		var boss = bosses[0].instantiate()
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
		spawnPosition = Vector2(1200, 1200)
	return spawnPosition

