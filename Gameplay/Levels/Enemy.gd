# Enemy.gd (keep this comment)
extends Node2D

var hp: int = 100:
	set(value):
		hp = max(value, 0)
		update_hp_label()
		if hp == 0:
			die()
	get:
		return hp

@onready var HPLabel = $Sprite2D/HPLabel

var attack: int = 15
var exp_reward: int = 50

func _ready():
	update_hp_label()

func take_damage(damage: int):
	hp -= damage

func update_hp_label():
	HPLabel.text = str(hp) + " HP"

func die():
	print("The enemy has died.")
	drop_loot()
	award_exp()
	queue_free()

func drop_loot():
	var loot_table = [
		{"item": "Gold", "chance": 0.2},
		{"item": "Potion", "chance": 0.1},
		{"item": "Sword", "chance": 0.07}
	]

	for loot in loot_table:
		if randf() < loot["chance"]:
			print("Dropped: ", loot["item"])
			# Add the item to the player's inventory here

func award_exp():
	var player = get_tree().root.get_node("Level01/Player")
	if player:
		player.gain_experience(exp_reward)
	else:
		print("Player node not found.")

func attack_player():
	var player = get_tree().root.get_node("Level01/Player")
	if player:
		var damage = calculate_damage()
		player.take_damage(damage)

func calculate_damage():
	return attack
