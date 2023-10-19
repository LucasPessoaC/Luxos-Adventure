extends Node2D

@onready var heartContainer = $CanvasLayer/HeartsContainer
@onready var player = $Player_Main
# Called when the node enters the scene tree for the first time.
func _ready():
	heartContainer.setMaxHearts(player.maxHealth/20)
	heartContainer.updateHearts(player.current_health)
	player.wasAttacked.connect(heartContainer.damageTaken)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

