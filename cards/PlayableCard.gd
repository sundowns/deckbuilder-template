extends Control
class_name PlayableCard

signal request_return_to_hand(card: PlayableCard, child_index: int)

var _has_initialised: bool = false

@export var type: Constants.CardType
@export var on_hover_scale_amount: Vector2 = Vector2(1.15, 1.15)
@export var on_selected_scale_amount: Vector2 = Vector2(1.15, 1.15)
const default_card_size: Vector2 = Vector2(Constants.default_card_width, Constants.default_card_width * Constants.card_height_to_width_ratio)
var card_size: Vector2 = Vector2.ONE
var card_data: CardData

# Should eventually be replaced with actual sprites for each card
@onready var background: ColorRect = $Background
@onready var is_selected_identifier: ColorRect = $IsSelectedIdentifier

var is_selected: bool = false
var is_being_dragged: bool = false

var movement_tween: Tween
var is_in_hand: bool = false

func _ready() -> void:
	if not _has_initialised:
		call_deferred("initialise") 

func set_card_type(new_type: Constants.CardType) -> void:
	type = new_type

func initialise():
	_has_initialised = true
	card_data = Cards.get_data(type)
	
	resize(default_card_size)
	background.color = card_data.colour
	
	is_selected_identifier.visible = false

func resize(new_card_size: Vector2) -> void:
	card_size = new_card_size
	size = card_size
	custom_minimum_size = card_size
	pivot_offset = card_size/2
	background.size = card_size

func get_centre_world_position() -> Vector2:
	return global_position + card_size/2

func _on_mouse_entered() -> void:
	if is_selected or Cards._is_dragging: return

func _on_mouse_exited() -> void:
	if is_selected or Cards._is_dragging: return

func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.is_pressed():
			Cards._on_card_mouse_pressed(self)
		elif event.is_released():
			Cards._on_card_mouse_released()

func begin_dragging() -> void:
	is_being_dragged = true
	set_physics_process(false)
	movement_tween.kill()

func end_dragging() -> void:
	is_being_dragged = false
	set_physics_process(true)
	if is_in_hand:
		request_return_to_hand.emit(self, get_index())

func select() -> void:
	is_selected = true
	is_selected_identifier.visible = true

func deselect() -> void:
	is_selected = false
	is_selected_identifier.visible = false

func move_towards(new_position: Vector2, centre_around_position: bool = true) -> void:
	var target := new_position
	if movement_tween and movement_tween.is_running():
		movement_tween.kill()
	if centre_around_position:
		target -= card_size/2
	movement_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	movement_tween.tween_property(self, "global_position", target, 0.65)

func _on_added_to_hand(hand: Hand) -> void:
	is_in_hand = true
	request_return_to_hand.connect(hand._on_card_return_to_hand, get_index())

func _on_removed_from_hand() -> void:
	is_in_hand = false
	for connection in request_return_to_hand.get_connections():
		connection['signal'].disconnect(connection['callable'])

func _to_string() -> String:
	return "<PlayableCard-" + self.card_data.title + " [" + str(get_instance_id()) + "]\\>"

# The format and contents of context depends on the game state being manipulated
func play(context = null) -> void:
	print("playing ", self)
	card_data._on_play(context)
