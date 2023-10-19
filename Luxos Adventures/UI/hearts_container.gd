extends HBoxContainer

@onready var HeartGuiClass = preload("res://UI/heart_gui.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func setMaxHearts(maxx : int):
	for i in range(maxx):
		var heart = HeartGuiClass.instantiate()
		add_child(heart)
		
		
func updateHearts(currentHealth : int, heatlh : int):
	var hearts = get_children()
	for i in range(currentHealth):
		hearts[i].update(true)
		hearts[i].updateText(str(heatlh))
		
		
		
#func damageHearts(currentHealth : int, damage : int):
#	var hearts = get_children()
#
#	if(currentHealth >= 0):
#		hearts[currentHealth].update(false)
	

func damageTaken(currentHealth : int, damage : int):
		var newHeatlh = currentHealth - damage
		var health = newHeatlh
		var hearts = get_children()
		for i in range(hearts.size()):
			hearts[i].updateText(str(health))
			if(newHeatlh >= 20):
				hearts[i].update(true)
				newHeatlh -= 20
			elif(newHeatlh >= 0):
				hearts[i].update(false, newHeatlh)
				newHeatlh = 0
			else:
				hearts[i].update(false, newHeatlh)
		
	
