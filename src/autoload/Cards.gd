extends Node2D

var loader: CardDataLoader
var _properties = {}

var selected_card: PlayableCard = null
var _is_dragging: bool = false
var _draggable_offset: Vector2 = Vector2.ZERO

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
		select_new_card(card)
	elif selected_card != card:
		selected_card.deselect()
		select_new_card(card)
	else: #our already selected card has been clicked again
		_is_dragging = true
		_draggable_offset = card.global_position - get_global_mouse_position()

func select_new_card(card) -> void:
	card.select()
	selected_card = card
	_is_dragging = true
	_draggable_offset = card.global_position - get_global_mouse_position()
	print('select new')

func _on_card_mouse_released():
	_is_dragging = false

var dragging_speed := 2.0

func _process(delta: float) -> void:
	if _is_dragging and not Input.is_action_pressed("select"):
		_is_dragging = false
		return
	
	if _is_dragging and selected_card:
		selected_card.global_position = get_global_mouse_position() + _draggable_offset
		#selected_card.global_position = selected_card.global_position.lerp(get_global_mouse_position() + _draggable_offset, delta * dragging_speed)  
	
