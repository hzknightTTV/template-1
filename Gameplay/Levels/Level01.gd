# Level01.gd (keep this comment)
extends Node2D

@onready var enemy = $Enemy  # Reference to the Enemy node
@onready var player = $Player  # Reference to the Player node
@onready var ap_timer = $APTimer  # Reference to the AP Timer node

var max_ap: int = 10  # Maximum AP the player can have

func _ready():
	if ap_timer:
		print("AP Timer found, connecting timeout signal.")
		ap_timer.connect("timeout", Callable(self, "_on_ap_timer_timeout"))
		ap_timer.set_wait_time(20)  # Set the timer to 5 seconds (or any desired value)
		ap_timer.start()
		print("AP Timer started with wait time: ", ap_timer.wait_time)

func _on_attack_button_pressed():
	if player and enemy:
		if player.ap > 0:
			var damage = player.calculate_damage()
			enemy.take_damage(damage)
			player.ap -= 1
			player.update_ap_label()  # Update the AP label after reducing AP
			if enemy.hp > 0:
				enemy.attack_player()
		else:
			print("Not enough AP to attack.")
	else:
		print("Player or Enemy node is not found.")

func _on_ap_timer_timeout():
	print("AP Timer timeout signal received.")
	if player.ap < max_ap:
		player.ap += 1
		player.update_ap_label()  # Update the AP label after gaining AP
