extends Node2D

var hp: int = 25:
	set(value):
		hp = max(value, 0)  # Ensure hp doesn't go below 0
		update_hp_label()
		if hp == 0:
			die()
	get:
		return hp

@onready var HPLabel = $Sprite2D/HPLabel

var strength: int = 10
var exp_reward: int = 50

func _ready():
	update_hp_label()

func take_damage(damage: int):
	hp -= damage

func update_hp_label():
	HPLabel.text = str(hp)

func die():
	print("The enemy has died.")
	drop_loot()
	award_exp()
	queue_free()  # Remove the enemy from the scene

func drop_loot():
	# Example loot table
	var loot_table = [
		{"item": "Gold", "chance": 0.5},
		{"item": "Potion", "chance": 0.3},
		{"item": "Sword", "chance": 0.2}
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
	return strength  # You can add more complex calculations if needed
