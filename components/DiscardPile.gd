extends Node2D
class_name DiscardPile

@onready var card_anchor: Node2D = $CardAnchor

# TODO: Maybe do something clever like visualise the top few cards and hide the rest

var cards: Array[PlayableCard] = []

func add_card(card: PlayableCard) -> void:
	if not cards.is_empty():
		cards.back().visible = false
	cards.push_back(card)
	
	# TODO: this will be the origin atm because its already been removed from the node tree... need to rethink slightly
	var cards_current_position: Vector2 = card.global_position
	card_anchor.add_child(card)
	card.global_position = cards_current_position
	card.move_towards(global_position)
