extends Node2D

@onready var hand: Hand = $Hand
@onready var discard_pile: DiscardPile = $DiscardPile

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_play_current_card"):
		play_selected_card()

func play_selected_card() -> void:
	var selected_card: PlayableCard = Cards.selected_card
	if selected_card and selected_card.is_in_hand:
		hand.remove_card(selected_card)
		selected_card.play()
		discard_card(selected_card)

# Assumes the card has already left the node tree (has no parent)
func discard_card(card: PlayableCard) -> void:
	discard_pile.add_card(card)
