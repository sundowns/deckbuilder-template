extends Node

# This order could be implicit, but I think its much safer to explicitly define them.
enum CardType {
	GREEN = 0,
	RED = 1,
}

const default_card_width: float = 100.0 #px
const card_height_to_width_ratio: float = 1.4
