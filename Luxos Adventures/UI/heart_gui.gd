extends Panel

@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update(whole : bool, remainingHealth : int = 100):
	if whole: 
		sprite.frame = 0
	else:
		remainingHealth = (remainingHealth*100)/20
		if(remainingHealth <= 75 && remainingHealth > 50):
			sprite.frame = 1
		elif(remainingHealth <= 50 && remainingHealth > 25):
			sprite.frame = 2
		elif(remainingHealth <= 25 && remainingHealth > 0):
			sprite.frame = 3
		elif(remainingHealth <= 0):
			sprite.frame = 4
		
