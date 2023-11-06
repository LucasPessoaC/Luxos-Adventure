extends Node2D

@onready var nodes = []
@onready var areaR = $SpawnAreaR
@onready var areaL = $SpawnAreaL
@onready var timer = $SpawnTimer
@onready var timerA = $SpawnARLTImer
@onready var spawn = preload("res://Levels/spawn_sprite.tscn")

var lastpicked:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	nodes = get_tree().get_nodes_in_group("spawn")
	areaR = get_tree().get_nodes_in_group("spawnAR")
	areaL = get_tree().get_nodes_in_group("spawnAL")
	timer.start()
	timerA.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spawn_timer_timeout():
	var rand = randi() % nodes.size()
	while(lastpicked == rand):
		rand = randi() % nodes.size()
	lastpicked = rand
	var node = nodes[rand]
	var Spawn = spawn.instantiate()
	Spawn.position = node.position
	add_child(Spawn)
	timer.start()


func _on_spawn_arlt_imer_timeout():
	var rand = randi_range(1,3)
	var Spawn = spawn.instantiate()
	if(rand == 1):
		var positionA = areaR[0].position + Vector2(randf() * areaR[0].size.x,randf() * areaR[0].size.y)
		Spawn.position = positionA
		add_child(Spawn)
	else:
		var positionAL = areaL[0].position + Vector2(randf() * areaL[0].size.x,randf() * areaL[0].size.y)
		Spawn.position = positionAL
		add_child(Spawn)
	timerA.start()
	
	
	
