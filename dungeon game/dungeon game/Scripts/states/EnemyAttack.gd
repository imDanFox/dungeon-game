extends State
class_name EnemyAttack

@export var enemy: CharacterBody2D
var direction: Vector2
var player: CharacterBody2D
var attacking: bool
var lunge_speed: int = 25.0

func attack(body):
	while enemy.is_attacking:
		var attack = Attack.new()
		attack.attack_damage = enemy.attack_damage
		attack.knockback_force = enemy.knockback_force
		attack.attack_position = enemy.global_position
		player.damage_player(attack)
		await get_tree().create_timer(2.0).timeout

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	enemy.velocity = Vector2()
	enemy.attack_thing.connect(attack)
	lunge()

func Physics_Update(delta: float):
	direction = player.global_position - enemy.global_position
	if direction.length() > 17:
		Transitioned.emit(self, "Follow")
		
func lunge():
	#input attack animation here
	enemy.velocity = direction.normalized() * lunge_speed
	await get_tree().create_timer(2.0).timeout
	Transitioned.emit(self, "Follow")



