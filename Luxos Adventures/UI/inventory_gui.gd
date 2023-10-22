extends Control

var isOpen : bool = false

signal opened
signal closed
signal potionChanged

@onready var inventory: Inventory = preload("res://Inventory/Items/playerInventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var potionSlot: Array = $NinePatchRect2/CenterContainer.get_children()

func _ready():
	inventory.updated.connect(update)
	for slot in slots:
		slot.potionChanged.connect(_on_potion_slot_potion_changed)
	update()

func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])
		
	for i in range(min(inventory.potionSlot.size(), potionSlot.size())):
		potionSlot[i].updatePotion(inventory.potionSlot[i])

func open():
	visible = true
	isOpen = true
	opened.emit()

func close():
	visible = false
	isOpen = false
	closed.emit()




func _on_potion_slot_potion_changed():
	emit_signal("potionChanged", false)


