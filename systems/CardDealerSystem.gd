extends Node
class_name CardDealerSystem

var deck: Array[Card] = []
var draw_pile: Array[Card] = []
var discard_pile: Array[Card] = []

func _ready() -> void:
	reset()

func reset() -> void:
	draw_pile = deck
	discard_pile = []

func create_card(type: Constants.CardType) -> Card:
	return Card.new(Cards.get_data(type), [])
