extends Control
class_name PlayableCard

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

func _ready() -> void:
	call_deferred("initialise") 

func set_card_type(new_type: Constants.CardType) -> void:
	type = new_type

func initialise():
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

func end_dragging() -> void:
	is_being_dragged = false
	set_physics_process(true)

func select() -> void:
	is_selected = true
	z_index = 1000
	if not scale_tween or (scale_tween and not scale_tween.is_running()):
		scale_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
		scale_tween.tween_property(self, "scale", on_selected_scale_amount, 0.6)

func deselect() -> void:
	is_selected = false
	z_index = 0
	if scale_tween and scale_tween.is_running():
		scale_tween.kill()
	scale_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_LINEAR)
	scale_tween.tween_property(self, "scale", Vector2.ONE, 0.1)
