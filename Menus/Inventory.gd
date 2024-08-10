# Inventory.gd (keep this comment)
extends Node2D

const SlotClass = preload("res://Menus/Slot.gd")
@onready var inventory_slots = $GridContainer
@onready var close_button: Button = $GridContainer/CloseButton  # Reference to the Close Button
var holding_item = null

func _ready():
	# Connect slot input handling
	for inv_slot in inventory_slots.get_children():
		inv_slot.connect("gui_input", Callable(self, "slot_gui_input").bind(inv_slot))
	
	# Connect the close button signal to the close_inventory method using Callable
	close_button.connect("pressed", Callable(self, "_on_close_button_pressed"))

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			# Currently holding an item
			if holding_item != null:
				# Empty slot
				if !slot.item:
					slot.putIntoSlot(holding_item)
					holding_item = null
				# Slot already contains an item
				else:
					# Different item, so swap
					if holding_item.item_name != slot.item.item_name:
						var temp_item = slot.item
						slot.pickFromSlot()
						temp_item.global_position = event.global_position
						slot.putIntoSlot(holding_item)
						holding_item = temp_item
					# Same item, so try to merge
					else:
						var stack_size = int(JsonData.item_data[slot.item.item_name]["StackSize"])
						var able_to_add = stack_size - slot.item.item_quantity
						if able_to_add >= holding_item.item_quantity:
							slot.item.add_item_quantity(holding_item.item_quantity)
							holding_item.queue_free()
							holding_item = null
						else:
							slot.item.add_item_quantity(able_to_add)
							holding_item.decrease_item_quantity(able_to_add)
			# Not holding an item
			elif slot.item:
				holding_item = slot.item
				slot.pickFromSlot()
				holding_item.global_position = get_global_mouse_position()

func _input(_event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()

func add_item(item):
	for slot in inventory_slots.get_children():
		if slot.item == null:
			slot.putIntoSlot(item)
			return true
	print("Inventory is full")
	return false

func _on_close_button_pressed():
	close_inventory()

func close_inventory():
	queue_free()
