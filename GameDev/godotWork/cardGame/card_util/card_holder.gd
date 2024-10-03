extends Container

# holds the given card once selected. Allows for the effect of: 'picking up a card from your hand'
# and being able to move it around the screen to be dropped/player at a given place


func _ready():
	init_sprite_scale()
	init_sprite_z()


func _run_dependencies():
	pass


# load default scaling
func init_sprite_scale():
	$Sprite.scale = Global.SCALE

# ensure card_holder is drawn ontop of any cards in hand
func init_sprite_z():
	$Sprite.z_index = 2
	# note: CavasLayer children appear to been drawn following order: foreground, Z-relative

func _process(delta):
	self.global_position = get_global_mouse_position()

