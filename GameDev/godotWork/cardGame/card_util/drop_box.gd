# Abstract i.e. no scence instance exisits to instantiate an object
extends Container

@onready var game = find_parent("game")

var vec
var filled = false
var card = null

func _ready():
	init_sprite_scale()
	init_sprite_texture()
	init_vec()
	init_self_size()
	init_sprite_position()


func _run_dependencies():
	pass


# load default scaling
func init_sprite_scale():
	$Sprite.scale = Global.SCALE


# load default sprite texture
func init_sprite_texture():
	$Sprite.texture = preload("res://assets/BoardDropBox.png")


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
