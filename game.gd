extends Node2D

@onready var hand: Hand = $Hand
@onready var discard_pile: DiscardPile = $DiscardPile

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_play_current_card"):
		play_selected_card()
	elif event.is_action_pressed("debug_discard_current_card"):
		discard_selected_card()

func play_selected_card() -> void:
	var selected_card: PlayableCard = Cards.selected_card
	if selected_card and selected_card.is_in_hand:
		selected_card.play()
		discard_card(selected_card)
		Cards.deselect_current_card()

func discard_selected_card() -> void:
	var selected_card: PlayableCard = Cards.selected_card
	if selected_card and selected_card.is_in_hand:
		selected_card.discard()
		discard_card(selected_card)
		Cards.deselect_current_card()

func discard_card(card: PlayableCard) -> void:
	var cards_previous_position: Vector2 = card.global_position
	if card.is_in_hand:
		hand.remove_card(card)
	discard_pile.add_card(card, cards_previous_position)
