extends Control

@onready var progressBar = $CenterContainer/Panel/TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("updateBossBar", updateHealth)
	SignalBus.connect("updateBossBarDead", deadBoss)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func deadBoss():
	visible = false

func updateHealth(damage:int):
	progressBar.value -= damage
