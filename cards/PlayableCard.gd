extends Control
class_name PlayableCard

@export var type: Constants.CardType
@export var on_hover_scale_amount: Vector2 = Vector2(1.15, 1.15)
@export var on_selected_scale_amount: Vector2 = Vector2(1.15, 1.15)
var default_card_size: Vector2 = Vector2(Constants.default_card_width, Constants.default_card_width * Constants.card_height_to_width_ratio)
var card_data: CardData

@onready var collision_area: Area2D = $Area2D 
@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D

# Debug node for visibility
@onready var background: ColorRect = $Background

var scale_tween: Tween
var is_selected: bool = false

func _ready() -> void:
	call_deferred("initialise") 

func initialise():
	card_data = Cards.get_data(type)
	
	var shape := RectangleShape2D.new()
	shape.size = default_card_size
	collision_shape.shape = shape
	collision_area.position = shape.size/2
	#collision_shape.position = shape.size/2
	
	background.size = shape.size
	background.color = card_data.colour
	pivot_offset = default_card_size/2

func _on_mouse_entered() -> void:
	if is_selected: return
	if scale_tween and scale_tween.is_running():
		scale_tween.kill()
	scale_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	scale_tween.tween_property(self, "scale", on_hover_scale_amount, 0.6)

func _on_mouse_exited() -> void:
	if is_selected: return
	if scale_tween and scale_tween.is_running():
		scale_tween.kill()
	scale_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	scale_tween.tween_property(self, "scale", Vector2.ONE, 0.4)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			Cards._on_card_clicked(self)

func select() -> void:
	is_selected = true
	if scale_tween and not scale_tween.is_running():
		scale_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
		scale_tween.tween_property(self, "scale", on_selected_scale_amount, 0.6)

func deselect() -> void:
	is_selected = false
	if scale_tween and scale_tween.is_running():
		scale_tween.kill()
	scale_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	scale_tween.tween_property(self, "scale", Vector2.ONE, 0.6)
