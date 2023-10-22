extends Control

@onready var backgroundSprite = $CenterContainer/Panel2/Sprite2D
@onready var sprite = $CenterContainer/Panel2/Panel/Sprite2D
@onready var label = $CenterContainer/Panel2/Panel/Label
@onready var cooldown = $TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	cooldown.value = 100
	cooldown.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!$Timer.is_stopped()):
		cooldown.value = ($Timer.time_left * 100)/10

func a (item: InventorySlot):
	if(!item.item):
		sprite.visible = false
		label.visible = false
		backgroundSprite.visible = true
	else:
		
		sprite.visible = true
		label.visible = true
		sprite.texture = item.item.texture
		label.text = str(item.amount)
		backgroundSprite.visible = false
	
func heal(item: InventorySlot, timer:bool):
	if(!item.item):
		sprite.visible = false
		label.visible = false
		backgroundSprite.visible = true
	else:
		sprite.visible = true
		label.visible = true
		sprite.texture = item.item.texture
		label.text = str(item.amount)
		backgroundSprite.visible = false
		
	if(timer):
		cooldown.visible = true
		$Timer.start()
	else:
		cooldown.visible = false
		
	
