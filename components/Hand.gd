extends Node2D
class_name Hand

# TODO: this class will manage keeping its children in order and in position similar to balatro (cause its cool :])

func _on_card_received(card: PlayableCard) -> void:
	print("added a card to hand: ", card)
	var card_position: Vector2 = global_position # Using hand's pos as a fallback
	if card.get_parent():
		card_position = card.global_position
		card.get_parent().remove_child(card)
	add_child(card)
	card.global_position = card_position
	
	# TODO: start a tween that moves the card from their previous location to the new location (probably a function inside the playable card itself?)
