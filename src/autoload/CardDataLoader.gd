extends Node
class_name CardDataLoader

signal loading_finished(data: Dictionary)

@export var green_card_resource: CardData = preload("res://cards/data/GreenCard.tres")
@export var red_card_resource: CardData = preload("res://cards/data/RedCard.tres")


var data: Dictionary = {}

func _init():
	validate_card_data()
	data = {
		Constants.CardType.GREEN: green_card_resource,
		Constants.CardType.RED: red_card_resource,
	}
	call_deferred("broadcast")

# Pre-loading checks on card data validity.
# Currently checks for duplicate indices, so we can assume uniqueness.
func validate_card_data() -> void:
	var all_keys := Constants.CardType.keys()
	var existing_indices = []
	for value in Constants.CardType.values():
		if existing_indices.has(value):
			# Note that the key will always show whatever the first associated value is in the array.
			push_error("Duplicate index encountered when loading card data: %s %d" % [all_keys[value], value])
		else:
			existing_indices.push_back(value)

func broadcast():
	loading_finished.emit(data)
