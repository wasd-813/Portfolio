extends Control

var vec

func _ready():
	init_sprite_scale()
	init_sprite_texture()
	init_vec()
	init_self_size()
	init_sprite_position()
	init_self_pos()


func _run_dependencies():
	pass


# load default scaling
func init_sprite_scale():
	$Sprite.scale = Global.SCALE


# load a default sprite
func init_sprite_texture():
	$Sprite.texture = preload("res://assets/HalfBoardLine.png")


# loads default vec value
func init_vec():
	vec = Vector2(
		$Sprite.texture.get_width() * Global.SCALE[0],
		$Sprite.texture.get_height() * Global.SCALE[1] 
		)


# load the container's size & min_size
func init_self_size():
	self.custom_minimum_size = vec
	self.size = vec # this is causing warnings and I dont know why?


# initalise position of sprite relative to Container parent node
func init_sprite_position():
	$Sprite.position = vec / 2


# position to half way down the screen
func init_self_pos():
	self.position = Vector2( 0, Global.WINDOW_HEIGHT / 2 - vec[1] / 2)
