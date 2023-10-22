extends TextureRect

@onready var inventory: Inventory = preload("res://Inventory/Items/playerInventory.tres")
signal potionChanged

func _get_drag_data(_at_position):
	var parente = get_parent()
	var index = parente.get_index()
	
	if(inventory.slots[index].item != null):
		var data = {}
		data["arrayTypeSaida"] = "Slot"
		data["arrayTypeEntrada"] = ""
		data["origin_texture"] = texture
		data["index_saiu"] = index
		data["item_name"] = inventory.slots[index].item.name
		var preview_texture = TextureRect.new()
		preview_texture.texture = texture
		preview_texture.expand_mode = 1
		preview_texture.size = Vector2(45,45)
		
		var preview = Control.new()
		preview.add_child(preview_texture)
		preview_texture.position = -0.5 * preview_texture.size
		
		set_drag_preview(preview)
		return data
		
func _can_drop_data(_at_position, data):
	
	return true
	return false
	
func _drop_data(_at_position, data):
	texture = data["origin_texture"]
	data["arrayTypeEntrada"] = "Slot"
#	texture = null
	if(data["arrayTypeSaida"] == "potionSlot"):
		inventory.swap(0, get_parent().get_index(), data["arrayTypeSaida"], data["arrayTypeEntrada"])
		emit_signal("potionChanged")
	else:
		inventory.swap(data["index_saiu"], get_parent().get_index(),  data["arrayTypeSaida"], data["arrayTypeEntrada"])
		


func _on_mouse_entered():
	var parente = get_parent()
	var index = parente.get_index()
	if(texture != null):
		tooltip_text = inventory.slots[index].item.name
