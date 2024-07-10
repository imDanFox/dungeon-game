extends CharacterBody2D
class_name animal

signal health_changed
signal attack_thing

#health, experience, level
#attack, item drops, track player, ondeath(), 
@export var baseHealth: int = 20
@export var level: int = 0
@export var attack_damage: int = 1
@export var knockback_force: int = 800
@export var attack_range: float = 10

