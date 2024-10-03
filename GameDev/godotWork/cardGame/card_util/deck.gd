# Abstract i.e. no scence instance exisits to instantiate an object
extends Node

# (height, width) of the sprite texture
var vec 

var cards = []
var discard_pile = []

func _ready():
	init_sprite_scale()
	init_sprite_texture()
	init_vec()
	init_self_size()
	init_self_pos()
	init_sprite_position()	


func _run_dependencies():
	init_cards() # dependency: 'card' objects


# load default scaling
func init_sprite_scale():
	$Sprite.scale = Global.SCALE


# load a default sprite
func init_sprite_texture():
	$Sprite.texture = preload("res://assets/DefaultDeck.png")


# loads default vec value
func init_vec():
	vec = $Sprite.texture.get_width() * Global.SCALE


# load the container's size & min_size
func init_self_size():
	self.custom_minimum_size = vec
	self.size = vec # this is causing warnings and I dont know why?


func init_self_pos():
	pass


# initalise position of sprite relative to Container parent node
func init_sprite_position():
	$Sprite.position = vec / 2


func init_cards():
	pass


func add_card(card):
	cards.append(card)


func remove_card(card):
	cards.erase(card)


func draw_card():
	var card = cards.pick_random()
	remove_card(card)
	return card


func add_to_discard_pile(card):
	discard_pile.append(card)
