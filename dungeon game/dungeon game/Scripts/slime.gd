extends animal
class_name slime

var health
var maxHealth = baseHealth + level*3.0
var is_attacking: bool


func _ready():
	health = maxHealth

func _physics_process(delta):
	move_and_slide()

func damage(attack: Attack):
	health -= attack.attack_damage
	health_changed.emit() 
	if health <= 0:
		queue_free()
	velocity = (global_position - attack.attack_position).normalized() * attack.knockback_force

func _on_hurtbox_body_entered(body):
	if body.has_method("damage_player"):
		is_attacking = true
		attack_thing.emit(body)

func _on_hurtbox_body_exited(body):
	is_attacking = false
