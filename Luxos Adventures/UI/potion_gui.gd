extends Control

@onready var backgroundSprite = $CenterContainer/Panel2/Sprite2D
@onready var sprite = $CenterContainer/Panel2/Panel/Sprite2D
@onready var label = $CenterContainer/Panel2/Panel/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
	

