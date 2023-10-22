extends Resource

class_name Inventory

signal updated

@export var slots: Array[InventorySlot]
@export var potionSlot: Array[InventorySlot]


func insert(item: InventoryItem):
	for slot in slots:
		if slot.item == item:
			slot.amount += 1
			updated.emit()
			return
	
	for i in range(slots.size()):
		if !slots[i].item:
			slots[i].item = item
			slots[i].amount = 1
			updated.emit()
			break

func remove(item_index: int):
	var itemRemoved = slots[item_index]
	slots[item_index] = InventorySlot.new()
	
	
func swap(index_saiu:int, index_entrou: int, arrayTypeSaida: String, arrayTypeEntrada: String):
	if(arrayTypeEntrada == "Slot" && arrayTypeSaida == "Slot"):
		var slotItem = slots[index_saiu].item
		var amount = slots[index_saiu].amount
		slots[index_saiu].item = slots[index_entrou].item
		slots[index_saiu].amount = slots[index_entrou].amount
		slots[index_entrou].item = slotItem
		slots[index_entrou].amount = amount
		updated.emit()
		
	elif(arrayTypeSaida == "potionSlot"):
		if (slots[index_entrou].item == null 
		|| slots[index_entrou].item.name == "Medium Potion" 
		|| slots[index_entrou].item.name == "Great Potion"
		|| slots[index_entrou].item.name == "Small Potion"):
			var slotItem = slots[index_entrou].item
			var amount = slots[index_entrou].amount
			slots[index_entrou].item = potionSlot[index_saiu].item
			slots[index_entrou].amount = potionSlot[index_saiu].amount
			potionSlot[index_saiu].item = slotItem
			potionSlot[index_saiu].amount = amount
		updated.emit()
		
	else:
		var slotItem = potionSlot[index_entrou].item
		var amount = potionSlot[index_entrou].amount
		if(potionSlot[index_entrou].item != slots[index_saiu].item):
			potionSlot[index_entrou].item = slots[index_saiu].item
			potionSlot[index_entrou].amount = slots[index_saiu].amount
			slots[index_saiu].item = slotItem
			slots[index_saiu].amount = amount
			updated.emit()
		else:
			potionSlot[index_entrou].amount += slots[index_saiu].amount
			slots[index_saiu].item = null
			slots[index_saiu].amount = 0
			updated.emit()
			
