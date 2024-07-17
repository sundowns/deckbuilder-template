extends Resource
class_name CardData

@export_category("Metadata")
@export var title: String
@export var description: String = ""

@export_category("Debug")
@export var colour: Color

@export var behaviour_script: GDScript = preload("res://cards/data/scripts/CardBehaviour.gd")
var behaviour_script_instance: Variant

func _init() -> void:
	call_deferred("initialise")

func initialise() -> void:
	if behaviour_script:
		behaviour_script_instance = behaviour_script.new()
	else:
		push_warning('No script was loaded for CardData with title: ', title)

func _to_string() -> String:
	return "CardData: %s />" % [title]

# The format and contents of context depends on the game state being manipulated
func _on_play(context) -> void:
	if behaviour_script_instance:
		behaviour_script_instance.play(context)

func _on_discard(context) -> void:
	if behaviour_script_instance:
		behaviour_script_instance.discard(context)

func _on_add_to_hand(context) -> void:
	if behaviour_script_instance:
		behaviour_script_instance.add_to_hand(context)
