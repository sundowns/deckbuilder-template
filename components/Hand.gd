extends Node2D
class_name Hand

@onready var card_anchor: Node2D = $CardAnchor

const x_offset_per_card: float = 50.0

func _on_card_received(card: PlayableCard) -> void:
	var card_position: Vector2 = global_position # Using hand's pos as a fallback for cards previous position
	if card.get_parent():
		card_position = card.global_position
		card.get_parent().remove_child(card)
	card_anchor.add_child(card)
	card.global_position = card_position
	card.move_towards(global_position + Vector2(card.get_index() * x_offset_per_card, 0))
	card._on_added_to_hand(self)

func _on_card_return_to_hand(card: PlayableCard, child_index: int) -> void:
	card.move_towards(global_position + Vector2(child_index * x_offset_per_card, 0))

func remove_card(card: PlayableCard) -> void:
	card_anchor.remove_child(card)
	card._on_removed_from_hand()
	realign_all_cards()

func realign_all_cards() -> void:
	for card in card_anchor.get_children():
		card.move_towards(global_position + Vector2(card.get_index() * x_offset_per_card, 0))
