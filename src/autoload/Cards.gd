extends Node

var loader: CardDataLoader
var _properties = {}

var selected_card: PlayableCard = null
var _is_dragging: bool = false

func _ready() -> void :
	loader = CardDataLoader.new()
	add_child(loader)
	loader.loading_finished.connect(self.load_data)

func load_data(data: Dictionary) -> void:
	_properties = data

func get_data(type: Constants.CardType):
	return _properties[type]

func _on_card_mouse_pressed(card: PlayableCard):
	if not selected_card:
		card.select()
		selected_card = card
		_is_dragging = true
	elif selected_card != card:
		selected_card.deselect()
		card.select()
		selected_card = card
		_is_dragging = true

func _on_card_mouse_released():
	_is_dragging = false

func _process(_delta: float) -> void:
	if _is_dragging:
		# Remember to store the offset of where it was pressed, so the card doesnt snap to the centre of the mouse
		print('dragging, lets move it..')
