extends "res://scripts/cards/minion_card.gd"


func init_sprite_texture():
	$Sprite.texture = preload("res://assets/CardB.png")


func init_stats():
	self.health = 2
	self.attack = 1
	self.cost = 1
