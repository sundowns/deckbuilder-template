class_name Card

# If your game always creates cards in the same state (i.e. a card of type X is always identical to all other cards of type x),
# then this class is fairly superfluous and instances of it can just be replaced passing the CardType enum around.
# If not then this card can carry other additional values that make sense for your game at the time of card generation.

var type: Constants.CardType
var card_data: CardData
var buffs: Array = []

func _init(_type, _base_data, _buffs): 
	self.type = _type
	self.card_data = _base_data
	self.buffs = _buffs

func _to_string() -> String:
	return "<Card-" + self.card_data.title + "\\>"
