# Abstract i.e. no scence instance exisits to instantiate an object
extends Container

@onready var game = find_parent("game")

# (height, width) of the sprite texture
var vec 

# remembering for future animations
var sprite_resting_pos

# card stats
var cost

func _ready():
	init_sprite_scale()
	init_sprite_texture()
	init_vec()
	init_self_size()
	init_sprite_position()
	init_sprite_z()
	
	set_sprite_resting_pos()
	
	init_stats()


func _run_dependencies():
	pass


# load default scaling
func init_sprite_scale():
	$Sprite.scale = Global.SCALE


# load a default sprite
func init_sprite_texture():
	$Sprite.texture = preload("res://assets/CardA.png")


# loads default vec value
func init_vec():
	vec = $Sprite.texture.get_width() * Global.SCALE


# load the container's size & min_size
func init_self_size():
	self.custom_minimum_size = vec
	self.size = vec # this is causing warnings and I dont know why?


# initalise position of sprite relative to Container parent node
func init_sprite_position():
	$Sprite.position = vec / 2
	

# ensure cards are printing above most UI elements
func init_sprite_z():
	$Sprite.z_index = 1


# save sprite start/resting position
func set_sprite_resting_pos():
	sprite_resting_pos = $Sprite.position


# load up some default stats
func init_stats():
	self.cost = 1


# wrapper for calling game controller's selected card func
func try_select_card():
	game.select_card(self)
