# Controller for game logic (& player logic)

extends Node

@onready var enemy = $UI/Enemy
@onready var player_hand_container = $UI/PlayerHandContainer
@onready var enemy_hand_container = $UI/EnemyHandContainer
@onready var card_holder = $UI/CardHolder
@onready var end_turn = $UI/EndTurnBut
@onready var half_board_line = $UI/HalfBoardLine
@onready var player_deck = $UI/PlayerDeck
@onready var enemy_deck = $UI/EnemyDeck
@onready var player_drop_boxes = $UI/PlayerDropBoxes
@onready var enemy_drop_boxes = $UI/EnemyDropBoxes

# null when a card is not selected, of type: card.tscn when a card is selected
var selected_card = null
var selected_box = null
var players_turn = true


func _ready():
	_run_dependencies()
	start_game()

# sibling of the _ready func
# custom function used to call all other object initalisation tasks that depend upon other objects
# within the scene. Typically these would cause null references if called within the _ready func.
# a controller will call this func once all objects in the scene have been instantiated,
# circumventing the null reference issue
# note: references to 'game' need not be included in _run_dependencies 
# note: each base class obj must have a _run_dependencies func, even if it is just passed
func _run_dependencies():
	# run child dependencies
	enemy._run_dependencies()
	player_hand_container._run_dependencies()
	enemy_hand_container._run_dependencies()
	card_holder._run_dependencies()
	end_turn._run_dependencies()
	half_board_line._run_dependencies()
	player_deck._run_dependencies()
	enemy_deck._run_dependencies()
	
	# run container children dependencies
	for i in player_drop_boxes.get_children():
		i._run_dependencies()
		
	for i in enemy_drop_boxes.get_children():
		i._run_dependencies()	
	
	# run other UI dependencies
	organise_enemy_drop_boxes()
	organise_player_drop_boxes()


# needs to be expounded. Currently getting issues of tasks being handled in nodes _ready functions
# when these nodes are siblings and not parents/children, these cannot always be processed in an
# appropriate order. Therefore, this is called at the end of the game's ready function, by which all
# other ready functions would have been called and objected instantiated accordingly
func start_game():
	enemy.fill_hand()
	start_players_turn()


func _process(delta):
	if Input.is_action_pressed("Restart"):
		get_tree().reload_current_scene()
		
	if Input.is_action_pressed("RightClick"):
		self.selected_box = null
		deselect_card(self.selected_card)
		
	if Input.is_action_pressed("LeftClick"):
		print("click at: " + str(get_viewport().get_mouse_position()))


# return type: void
# description: processes the selection of a given 'card'. When called from a card object, this is
# typically itself (self). Updates the visibility of the card & card holder. Keeps track of if
# a card is selected
# note: card must not be removed from parent tree, this will cause the hand to 'collapse' as
# the HBox re-sorts its children
func select_card(card):
	if(self.selected_card == null and players_turn):		
		# make card_holder visible, and card in hand invisible
		card.get_node("Sprite").visible = false
		card_holder.get_node("Sprite").visible = true
		
		# update sprite of card_holder according to texutre of selected card
		card_holder.get_node("Sprite").texture = card.get_node("Sprite").texture
		
		# keep track of if a card is selected
		self.selected_card = card


# return type: void
# description: inverse of select_card()
func deselect_card(card):
	if card != null:
		card.get_node("Sprite").visible = true
		card_holder.get_node("Sprite").visible = false
		
		if(card.position != null):
			card.animate_dehover()
		
		card_holder.get_node("Sprite").texture = null
		self.selected_card = null


# return type: void
# description: changes player_turn variable. Prompts end_turn button to change sprite. Prompts
# enemy to start its turn if needed
func change_turn():
	# swap turns
	self.players_turn = false if players_turn else true
	end_turn.swap_sprite(players_turn)
	
	# update all card s.t they have not attacked this turn
	for i in player_drop_boxes.get_children():
		if(i.card != null):
			i.card.attacked_this_turn = false
	for i in enemy_drop_boxes.get_children():
		if(i.card != null):
			i.card.attacked_this_turn = false
	
	if !players_turn:
		deselect_card(selected_card)
		enemy.start_turn()
	else:
		start_players_turn()
		

# return type: void
# description: drops a card into a playable drop_box location. Allows for the player to 'play a card'
func drop_card(drop_box, card):
	drop_box.filled = true
	drop_box.card = card
	# update texture for box
	drop_box.get_node("Sprite").texture = card.get_node("Sprite").texture
	
	card.attacked_this_turn = true
	
	if(players_turn):
		# handle card deslection
		deselect_card(card)
		# remove card from scene (it's data is stored in the player_deck.discard_pile)
		player_hand_container.remove_child(card)
	else:
		enemy_hand_container.remove_child(card)


# return type: void
# description: handles any repeat actions that need to happen at the start of each turn
func fill_players_hand():
	for i in range(player_hand_container.get_child_count(), Global.HANDSIZE):
		player_hand_container.add_child(player_deck.draw_card())


func start_players_turn():
	fill_players_hand()
	self.players_turn = true


func die(card):
	var box
	var player_card
	for i in player_drop_boxes.get_children():
		if i.card == card:
			box = i
			player_card = true
	for i in enemy_drop_boxes.get_children():
		if i.card == card:
			box = i
			player_card = false
	
	box.filled = false
	box.card = null
	box.init_sprite_texture()
	if(player_card):
		player_deck.add_to_discard_pile(card)
	else:
		enemy_deck.add_to_discard_pile(card)


func defeat_level():
	pass


func organise_player_drop_boxes():
	var j = 1
	for i in player_drop_boxes.get_children():
		var offset = i.get_node("Sprite").texture.get_width() * Global.SCALE[0] /2
		i.position = Vector2(
			j * Global.WINDOW_WIDTH / 4 - offset,
			3 * Global.WINDOW_HEIGHT / 4 - offset
			)
		j += 1


func organise_enemy_drop_boxes():
	var j = 1
	for i in enemy_drop_boxes.get_children():
		var offset = i.get_node("Sprite").texture.get_width() * Global.SCALE[0] / 2
		i.position = Vector2(
			j * Global.WINDOW_WIDTH / 4 - offset,
			Global.WINDOW_HEIGHT / 4 - offset
			)
		j += 1


func process_attack(att_box, def_box):	
	var att_card = att_box.card
	var def_card = def_box.card
	
	# only process the attack if the card has not already attacked
	if(!att_card.attacked_this_turn):
		att_card.attacked_this_turn = true
		def_card.take_damage(att_card.attack)	
		
		self.selected_box = null
		
		print("HERE")	
		# placeholder sprite updating for taking damage
		# need to move this to the actual card and update drop box sprites after each attack
		var node = Sprite2D.new()
		node.set_name("DamageHealthSprite")
		def_box.add_child(node)
		node.z_index = 100
		node.scale = Global.SCALE
		node.texture = preload("res://assets/RedOne.png")
		node.position = Vector2(125, 115)
