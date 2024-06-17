extends Node

var loader: CardDataLoader
var _properties = {}

var selected_card: PlayableCard = null

func _process(delta: float) -> void:
	pass

func _ready() -> void :
	loader = CardDataLoader.new()
	add_child(loader)
	loader.loading_finished.connect(self.load_data)

func load_data(data: Dictionary) -> void:
	_properties = data

func get_data(type: Constants.CardType):
	return _properties[type]

func _on_card_clicked(card: PlayableCard):
	if not selected_card:
		card.select()
		selected_card = card
	elif selected_card != card:
		selected_card.deselect()
		card.select()
		selected_card = card

#var _is_dragging: bool = false
#
#func begin_drag() -> void:
	#_is_dragging = true
#
#func end_drag() -> void:
	#_is_dragging = false
