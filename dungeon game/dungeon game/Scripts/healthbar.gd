extends TextureProgressBar
class_name health_bar

@export var character: CharacterBody2D

func _ready():
	#max_value = character.maxHealth
	value = max_value
	character.health_changed.connect(update)
	
func update():
	value = character.health * 100 / character.maxHealth
