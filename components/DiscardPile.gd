extends Node2D
class_name DiscardPile

@onready var card_anchor: Node2D = $CardAnchor

# TODO: Maybe do something clever like visualise the top few cards and hide the rest
# TODO: Currently we keep everything in the node tree, which is not ideal for performance

var cards: Array[PlayableCard] = []

func add_card(card: PlayableCard, cards_previous_position: Vector2) -> void:
	if not cards.is_empty():
		cards.back().visible = false
	cards.push_back(card)
	
	card_anchor.add_child(card)
	card.global_position = cards_previous_position
	card.move_towards(global_position)
