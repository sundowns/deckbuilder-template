extends Resource
class_name CardData

@export_category("Card Data")
@export var title: String
@export var description: String = ""

@export_category("Debug")
@export var colour: Color

func _to_string() -> String:
	return "CardData: %s />" % [title]
