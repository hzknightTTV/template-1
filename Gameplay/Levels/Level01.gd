extends Node2D

@onready var enemy = $Enemy  # Reference to the Enemy node
@onready var player = $Player  # Reference to the Player node

func _on_attack_button_pressed():
	if player and enemy:
		var damage = player.calculate_damage()
		enemy.take_damage(damage)
		if enemy.hp > 0:
			enemy.attack_player()
	else:
		print("Player or Enemy node is not found.")
