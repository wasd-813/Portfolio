extends "res://scripts/card_util/deck.gd"

@onready var enemy = $"../Enemy"
@onready var enemy_hand_container = $"../EnemyHandContainer"

const card_a_obj = preload("res://scenes/cards/card_a.tscn")


func init_cards():
	# instantiate some basic temporary cards
	for i in enemy.decksize:
		var card = card_a_obj.instantiate()
		self.add_card(card) 

	enemy.deck = self


func init_self_pos():
	var offset = $Sprite.texture.get_width() * Global.SCALE[0] / 2
	self.position = Vector2(
		Global.WINDOW_WIDTH - 2 * offset,
		Global.WINDOW_HEIGHT / 4 - offset
	)

