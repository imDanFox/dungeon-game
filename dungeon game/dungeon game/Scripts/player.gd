extends CharacterBody2D

signal health_changed
@export var speed = 50
@export var baseHealth: int = 20
var health
var maxHealth = baseHealth # (+ modifiers)
var knockback = Vector2.ZERO
var knocked = false
@onready var animations = $AnimationPlayer
var isAttacking: bool = false


var arrow = preload("res://Scenes/arrow.tscn")

func _ready():
	health = maxHealth 

func _input(event):
	if event.is_action_pressed("sword"):
		isAttacking = true
		fire("sword")
	if event.is_action_pressed("bow"):
		isAttacking = true
		fire("bow")
		

func fire(weapon):
	var mouse_from_player = get_global_mouse_position() - self.position
	var attack_direction: String = ""
	if abs(mouse_from_player.y) - abs(mouse_from_player.x) > 0:
		if mouse_from_player.y < 0: attack_direction = "Up"
		if mouse_from_player.y > 0: attack_direction = "Down" 
	else: 
		if mouse_from_player.x >= 0: attack_direction = "Right" 
		if mouse_from_player.x < 0: attack_direction = "Left" 
	animations.play(weapon + attack_direction)
	await animations.animation_finished
	isAttacking = false
	if animations.assigned_animation == ("bow" + attack_direction):
		var mouse_pos = get_global_mouse_position()
		$Marker2D.look_at(mouse_pos)
		var arrow_instance = arrow.instantiate()
		arrow_instance.rotation = $Marker2D.rotation
		arrow_instance.global_position = $Marker2D.global_position
		add_child(arrow_instance)
	

func _physics_process(delta):
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	if knocked:
		velocity = knockback
		knocked = false
	move_and_slide()
	updateAnimation()
	

func damage_player(attack: Attack):
	health -= attack.attack_damage
	health_changed.emit() 
	if health <= 0:
		print("u ded")
	knockback = (global_position - attack.attack_position).normalized() * attack.knockback_force
	knocked = true

func updateAnimation():
	if isAttacking: return
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
		animations.play("walk" + direction)

#----------#----------#----------#----------#----------#----------
#		The stuff below is to be modified and added to a weapon script
#----------#----------#----------#----------#----------#----------

var attack_damage := 5.0
var knockback_force := 1000.0

func _on_weapon_body_entered(body):
	if body.has_method("damage"):
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.knockback_force = knockback_force
		attack.attack_position = global_position
		body.damage(attack)
		print("dealt " + str(attack_damage)+ "dmg to enemy " + str(body.get_name()))
#----------#----------#----------#----------#----------#----------
#		The stuff above is to be modified and added to a weapon script
#----------#----------#----------#----------#----------#----------
