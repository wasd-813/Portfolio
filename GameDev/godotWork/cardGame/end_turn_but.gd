extends Button

# the end turn button


@onready var game = find_parent("game")

var vec

func _ready():
	init_sprite_scale()
	init_sprite_texture()
	init_vec()
	init_self_size()
	init_sprite_position()
	init_self_pos()
	init_focus_mode()


func _run_dependencies():
	pass


# load default scaling
func init_sprite_scale():
	$Sprite.scale = Global.SCALE


# load a default sprite
func init_sprite_texture():
	$Sprite.texture = preload("res://assets/EndTurnSpriteSheet.png")
	# set-up sprite sheet
	$Sprite.vframes = 2
	$Sprite.hframes = 1
	$Sprite.frame = 0


# loads default vec value
func init_vec():
	# vec is based upon raw png file. As its a non-sq sprite sheet the vec math is slightly altered
	vec = Vector2(
		$Sprite.texture.get_width() * Global.SCALE[0],
		$Sprite.texture.get_height() * Global.SCALE[1] / 2
		)


# load the container's size & min_size
func init_self_size():
	self.size = vec
	self.custom_minimum_size = vec


# initalise position of sprite relative to Container parent node
func init_sprite_position():
	# center sprite on button
	$Sprite.position = vec / 2


func init_self_pos():
	self.position = Vector2(0, 0)


# remove focus so button doesnt glow when clicked
func init_focus_mode():
	self.focus_mode = Control.FOCUS_NONE


func _on_pressed():
	if game.players_turn:
		game.change_turn()


func swap_sprite(turn_bool):
	$Sprite.frame = 0 if turn_bool else 1
