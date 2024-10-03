extends "res://scripts/card_util/deck.gd" 

const card_a_obj = preload("res://scenes/cards/card_a.tscn")
const card_b_obj = preload("res://scenes/cards/card_b.tscn")


func init_cards():
	# instantiate some basic temporary cards
	var card
	for i in Global.DECKSIZE / 2:
		card = card_a_obj.instantiate()
		self.add_card(card)
	
	for i in Global.DECKSIZE / 2:
		card = card_b_obj.instantiate()
		self.add_card(card)



func init_self_pos():
	var offset = $Sprite.texture.get_width() * Global.SCALE[0] / 2
	self.position = Vector2(
		Global.WINDOW_WIDTH - 2 * offset,
		3 * Global.WINDOW_HEIGHT / 4 - offset
	)
	
