extends Node2D

@onready var animations = $AnimatedSprite2D
var speed = 100
var attack_damage = 5
var knockback_force = 150

func _ready():
	set_as_top_level(true)
	#animations.play("shoot")

func _process(delta):
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	if body.has_method("damage"):
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.knockback_force = knockback_force
		attack.attack_position = global_position
		body.damage(attack)
		queue_free()
		print("dealt " + str(attack_damage)+ "dmg to enemy " + str(body.get_name()))
	if body is TileMap:
		queue_free()
