extends Area2D

@export var itemRes: InventoryItem
var canPickup : bool = true
func _ready():
	$Timer.start()
	canPickup = false

func startTimer():
	$Timer.start()
	canPickup = false
	

func collect(inventory: Inventory):
	if(canPickup):
		inventory.insert(itemRes)
		queue_free()
		


func _on_timer_timeout():
	canPickup = true
	
