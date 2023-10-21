extends Panel


@onready var backgroundSprite: Sprite2D = $Background
@onready var itemSprite: Sprite2D = $TextureRect/CenterContainer/Panel/Item
@onready var label: Label = $TextureRect/CenterContainer/Panel/Label
@onready var textureRect: TextureRect = $TextureRect


func update(slot: InventorySlot):
	if !slot.item:
		itemSprite.visible = false
		label.visible = false
		textureRect.texture = null
	else:
#		itemSprite.visible = true
#		if (item.name == "Bone"):
		itemSprite.scale = Vector2(0.5,0.5)
		itemSprite.texture = slot.item.texture
		textureRect.texture = slot.item.texture
#		print(textureRect.texture)
		label.visible = true
		label.text = str(slot.amount)


