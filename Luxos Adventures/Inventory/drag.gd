extends TextureRect

@onready var inventory: Inventory = preload("res://Inventory/Items/playerInventory.tres")

func _get_drag_data(_at_position):
	var parente = get_parent()
	var index = parente.get_index()
	
	if(inventory.slots[index].item != null):
		var data = {}
		data["origin_texture"] = texture
		data["index_saiu"] = index
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
	
	return true
	return false
	
func _drop_data(at_position, data):
	texture = data["origin_texture"]
#	texture = null
	inventory.swap(data["index_saiu"], get_parent().get_index())
