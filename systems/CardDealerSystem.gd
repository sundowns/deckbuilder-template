extends Node
class_name CardDealerSystem

signal deck_empty
signal deal(card: Card)

var deck: Deck
var draw_pile: Array[Card] = []

func _ready() -> void:
	await Cards.cards_loaded
	load_deck("res://decks/Default.tres")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_draw_card"):
		draw_card()
	elif event.is_action_pressed("debug_print_draw_pile"):
		debug_print_draw_pile()

func create_card(type: Constants.CardType) -> Card:
	return Card.new(Cards.get_data(type), [])

func draw_card() -> void:
	if draw_pile.is_empty():
		draw_out()
		return
	var card: Card = draw_pile.pop_back()
	deal.emit(card)
	print('drew a .. ', card)

func draw_out() -> void:
	print('deck is empty!')
	deck_empty.emit()

func load_deck(resource_path: String) -> void:
	var loaded_resource: Deck = ResourceLoader.load(resource_path, "Deck", ResourceLoader.CACHE_MODE_REUSE)
	print('loading deck... ' , loaded_resource)
	deck = loaded_resource
	reset_draw_pile(deck.shuffle_cards)

func reset_draw_pile(shuffle: bool = false) -> void:
	assert(deck, "Attempted to reset draw pile without a loaded deck :(")
	draw_pile = []
	for card in deck.cards:
		draw_pile.push_back(create_card(card))
	if shuffle:
		shuffle_draw_pile()

func shuffle_draw_pile() -> void: pass # stub atm

func debug_print_draw_pile() -> void:
	print('---')
	for card in draw_pile: # debug prints
		print(card)
