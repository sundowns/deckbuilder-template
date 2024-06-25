extends Node
class_name CardDealerSystem

signal deck_empty

var deck: Array[Card] = []
var draw_pile: Array[Card] = []
var discard_pile: Array[Card] = []

func _ready() -> void:
	reset()
	await Cards.cards_loaded
	load_deck(load("res://decks/Default.tres"))

func reset() -> void:
	draw_pile = deck
	discard_pile = []

func create_card(type: Constants.CardType) -> Card:
	return Card.new(Cards.get_data(type), [])

func draw_card() -> void:
	if deck.is_empty():
		draw_out()
		return
	# TODO: continue this function
	# Do we emit a signal and remove it from the deck maybe? Have the card be another entity?

func draw_out() -> void:
	print('deck is empty!')
	deck_empty.emit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_draw_card"):
		draw_card()

func load_deck(deck_to_load: Deck) -> void:
	print('loading deck... ' , deck_to_load)
	for card in deck_to_load.cards:
		deck.push_back(create_card(card))
	for card in deck: # debug prints
		print(card)
