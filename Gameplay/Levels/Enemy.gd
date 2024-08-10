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
@onready var wraith_takes_damage = $WraithTakesDamage
@onready var wraith_dies = $WraithDies

var attack: int = 15
var exp_reward: int = 50

func _ready():
	update_hp_label()

func take_damage(damage: int):
	hp -= damage
	wraith_takes_damage.play()

func update_hp_label():
	HPLabel.text = str(hp) + " HP"

func die():
	print("The enemy has died.")
	drop_loot()
	award_exp()
	
	if wraith_dies:
		if wraith_takes_damage.is_playing():
			await wraith_takes_damage.finished
		wraith_dies.play()
		await wraith_dies.finished # Wait until the death sound finishes playing
	
	queue_free()  # Remove the enemy node after the sound effect

func drop_loot():
	var loot_table = [
		{"item": "Gold", "chance": 0.7},
		{"item": "Potion", "chance": 0.5},
		{"item": "Blood Staff", "chance": 0.1}
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
