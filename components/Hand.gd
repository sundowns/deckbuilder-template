extends Node2D
class_name Hand

# TODO: this class will manage keeping its children in order and in position similar to balatro (cause its cool :])

func _on_card_gained(card: Card) -> void:
	print("added a card to hand: ", card)
	var playable: PlayableCard = Cards.create_playable_card(card)
	add_child(playable)
