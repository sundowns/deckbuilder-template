extends Node2D
class_name DrawPile

signal card_drawn(card: PlayableCard)

# Creates a playable card and places it in the scene above the draw pile, then emits a signal
func _on_card_drawn(card: Card) -> void:
	print("drew a card: ", card)
	var playable: PlayableCard = Cards.create_playable_card(card)
	add_child(playable)
	playable.initialise()
	playable.global_position = global_position - playable.card_size/2
	card_drawn.emit(playable)
