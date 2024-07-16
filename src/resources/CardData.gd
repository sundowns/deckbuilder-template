extends Resource
class_name CardData

@export_category("Metadata")
@export var title: String
@export var description: String = ""

@export_category("Debug")
@export var colour: Color

@export var play_script: GDScript = preload("res://cards/data/scripts/CardBehaviour.gd")
var play_script_instance: Variant

func _init() -> void:
	call_deferred("initialise")

func initialise() -> void:
	if play_script:
		play_script_instance = play_script.new()
	else:
		push_warning('No script was loaded for CardData with title: ', title)

func _to_string() -> String:
	return "CardData: %s />" % [title]

# The format and contents of context depends on the game state being manipulated
func _on_play(context) -> void:
	if play_script_instance:
		play_script_instance.play(context)
