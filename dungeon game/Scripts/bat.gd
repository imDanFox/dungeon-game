extends animal
class_name bat

var health

func _ready():
	health = maxHealth + level*3.0

func _physics_process(delta):
	move_and_slide()

func damage(attack: Attack):
	health -= attack.attack_damage
	if health <= 0:
		queue_free()
	velocity = (global_position - attack.attack_position).normalized() * attack.knockback
