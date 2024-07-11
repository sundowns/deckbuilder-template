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

@onready var collision_area: Area2D = $Area2D 
@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D

# Should eventually be replaced with actual sprites for each card
@onready var background: ColorRect = $Background

var scale_tween: Tween
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
	
	card_size = default_card_size
	var shape := RectangleShape2D.new()
	shape.size = card_size
	collision_shape.shape = shape
	collision_area.position = shape.size/2
	
	background.size = shape.size
	background.color = card_data.colour
	pivot_offset = card_size/2
	custom_minimum_size = card_size

func get_centre_world_position() -> Vector2:
	return global_position + card_size/2

func _on_mouse_entered() -> void:
	if is_selected or Cards._is_dragging: return
	if scale_tween and scale_tween.is_running():
		scale_tween.kill()
	scale_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	scale_tween.tween_property(self, "scale", on_hover_scale_amount, 0.6)

func _on_mouse_exited() -> void:
	if is_selected or Cards._is_dragging: return
	if scale_tween and scale_tween.is_running():
		scale_tween.kill()
	scale_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	scale_tween.tween_property(self, "scale", Vector2.ONE, 0.4)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
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
	if not scale_tween or (scale_tween and not scale_tween.is_running()):
		scale_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
		scale_tween.tween_property(self, "scale", on_selected_scale_amount, 0.6)

func deselect() -> void:
	is_selected = false
	if scale_tween and scale_tween.is_running():
		scale_tween.kill()
	scale_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_LINEAR)
	scale_tween.tween_property(self, "scale", Vector2.ONE, 0.1)

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


# TODO: Need to figure out another way to handle clicking on cards, that actually consumes events (z-index is just a visual thing, not input)
# TODO: See https://www.reddit.com/r/godot/comments/fdmsw3/overlapping_input_events/
