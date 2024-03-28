extends CharacterBody2D

@export var speed = 50

func _physics_process(delta):
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	move_and_slide()


#----------#----------#----------#----------#----------#----------
#		The stuff below is to be modified and added to a weapon script
#----------#----------#----------#----------#----------#----------
var attack_damage := 5.0
var knockback := 1000.0


func _on_test_hurtbox_body_entered(body):
	if body.has_method("damage"):
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.knockback = knockback
		attack.attack_position = global_position
		body.damage(attack)
		print("dealt " + str(attack_damage)+ "dmg to enemy " + str(body.get_name()))
#----------#----------#----------#----------#----------#----------
#		The stuff above is to be modified and added to a weapon script
#----------#----------#----------#----------#----------#----------
