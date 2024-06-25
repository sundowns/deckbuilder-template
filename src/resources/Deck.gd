extends Resource
class_name Deck

@export_category("Metadata")
@export var title: String
@export var description: String = ""

@export_category("Cards")
@export var shuffle_cards: bool = false
@export var cards: Array[Constants.CardType]

func _to_string() -> String:
	return "Deck: %s />" % [title]
