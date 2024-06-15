extends Node2D

@export var type: Constants.CardType

@onready var background: ColorRect = $Background
var card_data: CardData

func _ready() -> void:
	call_deferred("initialise") 

func initialise():
	card_data = Cards.get_data(type)
	background.size.x = Constants.default_card_width
	background.size.y = background.size.x * Constants.card_height_to_width_ratio
	background.color = card_data.colour
