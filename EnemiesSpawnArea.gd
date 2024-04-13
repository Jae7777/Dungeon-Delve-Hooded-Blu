extends Node2D


var player
var spawnRadius = 100
var numEnemiesToSpawn = 5
var enemy_scene: PackedScene = preload("res://Scenes/ghost_enemy.tscn")

func _ready():
	player = $"../Player"
	spawnEnemies()
	
func _process(_delta):
	pass

func spawnEnemies():
	for i in range(numEnemiesToSpawn):
		var spawnPosition = calculateRandomSpawnPosition()
		var enemy = enemy_scene.instantiate()
		enemy.position = spawnPosition
		add_child(enemy)

func calculateRandomSpawnPosition():
	var angle = randf_range(0, 2 * PI)
	var distance = randf_range(2000, spawnRadius)
	var xOffset = distance * cos(angle)
	var yOffset = distance * sin(angle)
	var spawnPosition = player.position + Vector2(xOffset, yOffset)
	return spawnPosition
