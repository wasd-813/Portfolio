# Abstract i.e. no scence instance exisits to instantiate an object
extends "res://scripts/cards/player_card.gd"

# card stats
var health
var attack

var attacked_this_turn

func init_stats():
	self.cost = 1
	self.health = 1
	self.attack = 1
	self.attacked_this_turn = false


func take_damage(damage):
	health -= damage
	if health <= 0:
		game.die(self)


func die():
	pass
