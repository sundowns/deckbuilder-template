extends Node

var loader: CardDataLoader
var _properties = {}

func _ready() -> void :
	loader = CardDataLoader.new()
	add_child(loader)
	loader.loading_finished.connect(self.load_data)

func load_data(data: Dictionary) -> void:
	_properties = data

func get_data(type: Constants.CardType):
	return _properties[type]

var _is_dragging: bool = false

func begin_drag() -> void:
	_is_dragging = true

func end_drag() -> void:
	_is_dragging = false
