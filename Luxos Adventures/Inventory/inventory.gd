extends Resource

class_name Inventory

signal updated

@export var slots: Array[InventorySlot]

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
	
	
func swap(index_saiu:int, index_entrou: int):
	var slotItem = slots[index_saiu].item
	var amount = slots[index_saiu].amount
	slots[index_saiu].item = slots[index_entrou].item
	slots[index_saiu].amount = slots[index_entrou].amount
	slots[index_entrou].item = slotItem
	slots[index_entrou].amount = amount
	updated.emit()

	
