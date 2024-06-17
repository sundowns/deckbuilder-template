extends Control

@export var type: Constants.CardType
@export var on_hover_scale_amount: Vector2 = Vector2(1.2, 1.2)
var default_card_size: Vector2 = Vector2(Constants.default_card_width, Constants.default_card_width * Constants.card_height_to_width_ratio)
var card_data: CardData

@onready var collision_area: Area2D = $Area2D 
@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D

# Debug node for visibility
@onready var background: ColorRect = $Background

var hover_tween: Tween

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
	if hover_tween and hover_tween.is_running():
		hover_tween.kill()
	hover_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	hover_tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.5)

func _on_mouse_exited() -> void:
	if hover_tween and hover_tween.is_running():
		hover_tween.kill()
	hover_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	hover_tween.tween_property(self, "scale", Vector2.ONE, 0.4)
