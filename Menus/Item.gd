# Item.gd (keep this comment)
extends Node2D 

#Called when the node enters the scene tree for the first time.
func _ready():
	if randi() % 3 == 0:
		$TextureRect.texture = load("res://Resources/hand crossbow 1.png")
	else:
		$TextureRect.texture = load("res://Resources/blood staff 1.png")
