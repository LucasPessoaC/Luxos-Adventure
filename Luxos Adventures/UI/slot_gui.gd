extends Panel


@onready var backgroundSprite: Sprite2D = $Background
@onready var itemSprite: Sprite2D = $TextureRect/CenterContainer/Panel/Item
@onready var itemSpritePotion: Sprite2D = $TextureRect/CenterContainer/Panel/Sprite2D
@onready var label: Label = $TextureRect/CenterContainer/Panel/Label
@onready var textureRect: TextureRect = $TextureRect
@onready var backDefault: Sprite2D =  $PotionBack

signal potionChanged

func update(slot: InventorySlot):
	if !slot.item:
		itemSprite.visible = false
		label.visible = false
		textureRect.texture = null
		textureRect.tooltip_text = ""
		
	else:
		itemSprite.scale = Vector2(0.5,0.5)
		itemSprite.texture = slot.item.texture
		textureRect.texture = slot.item.texture
		label.visible = true
		label.text = str(slot.amount)

func updatePotion(slot:InventorySlot):
	if !slot.item:
		itemSpritePotion.visible = false
		label.visible = false
		textureRect.texture = null
		textureRect.tooltip_text = ""
		backDefault.visible = true
		
	else:
		itemSpritePotion.scale = Vector2(0.5,0.5)
		itemSpritePotion.texture = slot.item.texture
		textureRect.texture = slot.item.texture
		label.visible = true
		label.text = str(slot.amount)
		backDefault.visible = false



func _on_texture_rect_potion_changed():
	emit_signal("potionChanged")


func _on_texture_rect_potion_changed_slot():
	emit_signal("potionChanged")
