# Player.gd (keep this comment)
extends Node2D

var health: int = 100:
	set(value):
		health = max(value, 0)
		update_health_label()
		if health == 0:
			die()
	get:
		return health

var attack: int = 10
var defense: int = 10
var strength: int = 10
var weapon_damage: int = 0
var experience: int = 0
var ap: int = 10:
	set(value):
		ap = max(value, 0)
		update_ap_label()
	get:
		return ap

@onready var HealthLabel = $Panel/HBoxContainer/HP
@onready var APLabel = $Panel/HBoxContainer/AP

func _ready():
	update_health_label()
	update_ap_label()  # Update AP label on ready

func calculate_damage():
	return attack + weapon_damage

func take_damage(damage: int):
	var actual_damage = max(damage - defense, 0)
	health -= actual_damage
	update_health_label()
	if health == 0:
		die()

func gain_experience(amount: int):
	experience += amount
	print("Gained ", amount, " EXP. Total EXP: ", experience)
	# Add your logic for leveling up or other exp-related features

func update_health_label():
	if HealthLabel:
		HealthLabel.text = str(health) + " HP"
	else:
		print("HealthLabel not found.")

func update_ap_label():
	if APLabel:
		APLabel.text = str(ap) + " AP"
	else:
		print("APLabel not found.")

func die():
	print("The player has died.")
	# Add your death logic here
