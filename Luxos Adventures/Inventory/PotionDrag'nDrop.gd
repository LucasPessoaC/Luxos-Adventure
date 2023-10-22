extends TextureRect

@onready var inventory: Inventory = preload("res://Inventory/Items/playerInventory.tres")
signal potionChanged

func _get_drag_data(_at_position):
	var parente = get_parent()
	var index = parente.get_index()
	
	if(inventory.potionSlot[index].item != null):
		var data = {}
		data["arrayTypeSaida"] = "potionSlot"
		data["origin_texture"] = texture
		data["arrayTypeEntrada"] = ""
		data["index_saiu"] = index
		data["item_name"] = inventory.potionSlot[index].item.name
		var preview_texture = TextureRect.new()
		preview_texture.texture = texture
		preview_texture.expand_mode = 1
		preview_texture.size = Vector2(45,45)
		
		var preview = Control.new()
		preview.add_child(preview_texture)
		preview_texture.position = -0.5 * preview_texture.size
		
		set_drag_preview(preview)
		return data
		
func _can_drop_data(at_position, data):
	if(data["item_name"] == "Small Potion" || data["item_name"] == "Medium Potion" || data["item_name"] == "Great Potion" ):
		return true
	else:
		return false
	
func _drop_data(at_position, data):
	texture = data["origin_texture"]
	data["arrayTypeEntrada"] = "potionSlot"
	inventory.swap(data["index_saiu"], 0, data["arrayTypeSaida"], data["arrayTypeEntrada"])
	emit_signal("potionChanged")


func _on_mouse_entered():
	var parente = get_parent()
	var index = parente.get_index()
	if(texture != null && inventory.potionSlot[index].item.name != null):
		tooltip_text = inventory.potionSlot[index].item.name
