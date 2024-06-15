class_name Card

var card_data: CardData
var buffs: Array = []

func _init(_base_data, _buffs): 
	self.card_data = _base_data
	self.buffs = _buffs
