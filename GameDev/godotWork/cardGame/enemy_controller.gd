# controler for enemy game logic
# have used seperate controller due to the need for ememy sprites, later varianace in enemy
# types & sub-classes, and the potential complexity in their AI logic
extends Container

# the enemy of the level

@onready var game = find_parent("game")
@onready var enemy_hand_container = $"../EnemyHandContainer"
@onready var enemy_drop_boxes = $"../EnemyDropBoxes"
@onready var player_drop_boxes = $"../PlayerDropBoxes"

var vec

var health
var deck
var decksize
var handsize

func _ready():
	init_sprite_scale()
	init_sprite_texture()
	init_vec()
	init_self_size()
	init_self_pos()
	init_sprite_position()
	init_stats()


func _run_dependencies():
	pass


 # load default scaling
func init_sprite_scale():
	$Sprite.scale = Global.SCALE

# load a default sprite
func init_sprite_texture():
	$Sprite.texture = preload("res://assets/Enemy.png")


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


# load default position
func init_self_pos():	
	self.position = Vector2(
		(Global.WINDOW_WIDTH / 3) - vec[0] / 2,
		0
		)


# initalise position of sprite relative to Container parent node
func init_sprite_position():
	$Sprite.position = vec / 2


func init_stats():
	self.health = 1
	self.deck = null
	self.decksize = 10
	self.handsize = 5


func fill_hand():
	for i in range(enemy_hand_container.get_child_count(), self.handsize):
		enemy_hand_container.add_child(deck.draw_card())


func start_turn():
	# draw cards
	fill_hand()
	
	# play one card in a playable location
	for i in enemy_drop_boxes.get_children():
		if !i.filled:
			game.drop_card(i, enemy_hand_container.get_child(0))
			break
		
	for i in enemy_drop_boxes.get_children():
		if i.filled && !i.card.attacked_this_turn:
			var target = find_attack_target()
			if(target != null):
				game.process_attack(i, target)
		
	# end turn
	await get_tree().create_timer(1).timeout
	game.change_turn()


func take_damage(damage):
	health -= damage
	if health <= 0:
		game.defeat_level()

# returns a player box for which a card can attack
func find_attack_target():

	# checking player_drop_boxes has at least one valid target
	var flag = false
	for i in player_drop_boxes.get_children():
		if i.filled:
			flag = true
	if !flag:
		return null

	# picking random target
	var target = player_drop_boxes.get_children().pick_random()
	while(!target.filled):
		target = player_drop_boxes.get_children().pick_random()
	
	return target
