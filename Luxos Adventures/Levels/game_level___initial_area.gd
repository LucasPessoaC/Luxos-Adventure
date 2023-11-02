extends Node2D

@onready var heartContainer = $CanvasLayer/Control/HeartsContainer
@onready var player = $Player_Main
@onready var potionGUI = $CanvasLayer/PotionGUI
@onready var dayCicle = $DayTimeCicle
# Called when the node enters the scene tree for the first time.
func _ready():
	var a = $"CanvasLayer/Transição"
	a.set_next_animation(false)
	heartContainer.setMaxHearts(player.maxHealth/20)
	heartContainer.updateHearts(player.current_health, player.health)
	player.wasAttacked.connect(heartContainer.damageTaken)
	player.potionChanged.connect(potionGUI.a)
	player.potionChangedHeal.connect(potionGUI.heal)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _on_inventory_gui_closed():
	get_tree().paused = false



func _on_inventory_gui_opened():
	get_tree().paused = true


