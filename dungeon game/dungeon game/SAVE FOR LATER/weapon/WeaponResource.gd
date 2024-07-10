#FEATURE NOT USED

extends Resource #make an item resource to extend from with variables such as "value, weight" for shops and inventories.
class_name weapon_resource 

var attack_damage: int
var knockback: int
var durability: int
var range: int
var texture: Texture2D
var rarity: int
var weapon_name: String
var hitbox: Area2D

#    - magic  - (magic_weapon script that extends weapon (likely not necessary))
var is_magic: bool
var magic_damage: int

#    -  -  -  -
