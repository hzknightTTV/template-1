extends Node2D

var health: int = 100:
	set(value):
		health = max(value, 0)
		update_health_label()
		if health == 0:
			die()
	get:
		return health

var attack: int = 20
var defense: int = 10
var agility: int = 15
var weapon_damage: int = 15
var experience: int = 0  # Renamed from exp to experience

@onready var HealthLabel = $HealthLabel  # Ensure this path is correct

func _ready():
	update_health_label()

func calculate_damage():
	return attack + weapon_damage

func take_damage(damage: int):
	var actual_damage = max(damage - defense, 0)  # Reduce damage by defense, ensuring it doesn't go below 0
	health -= actual_damage
	update_health_label()
	if health == 0:
		die()

func gain_experience(amount: int):
	experience += amount
	print("Gained ", amount, " EXP. Total EXP: ", experience)
	# Add your logic for leveling up or other exp-related features

func update_health_label():
	if HealthLabel:  # Check if HealthLabel exists
		HealthLabel.text = str(health)
	else:
		print("HealthLabel not found.")

func die():
	print("The player has died.")
	# Add your death logic here
