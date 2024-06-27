class_name Card

var type: Constants.CardType
var card_data: CardData
var buffs: Array = []

func _init(_type, _base_data, _buffs): 
	self.type = _type
	self.card_data = _base_data
	self.buffs = _buffs

func _to_string() -> String:
	return "<Card-" + self.card_data.title + "\\>"
