extends Area2D

@onready var boss = preload("res://Characters/Enemies/wizard.tscn")

@onready var healthBar = $"../CanvasLayer/Boss Healthbar"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	if(body.is_in_group("player")):
		var tree = get_tree()
		if(!tree.has_group("boss")):
			var Boss = boss.instantiate()
			var node = tree.get_first_node_in_group("spawnBoss")
			Boss.player = get_tree().get_first_node_in_group("player")
			Boss.position = node.position
			node.get_parent().add_child(Boss)
			healthBar.visible = true
			var a1 = healthBar.get_children()
			var a2 = a1[0].get_children()
			var a3 = a2[0].get_children()
			var a4 = Boss.get_child(8)
			a3[1].max_value = a4.health
			a3[1].value = a4.health
			
		
