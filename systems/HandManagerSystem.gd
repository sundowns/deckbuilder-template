extends Node
class_name HandManagerSystem

@export var card_anchor_node: Node

func _on_card_gained(card: Card) -> void:
	print("added a card to hand: ", card)
	var playable: PlayableCard = Cards.create_playable_card(card)
	card_anchor_node.add_child(playable)
