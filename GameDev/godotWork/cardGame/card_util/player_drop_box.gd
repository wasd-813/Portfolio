extends "res://scripts/card_util/drop_box.gd"


func _on_gui_input(event):
	if Input.is_action_pressed("LeftClick") and !filled and game.selected_card != null:
		game.drop_card(self, game.selected_card)
		return	
		
	if game.selected_card != null:
		return
		
	# selects a box to use to attack
	if Input.is_action_pressed("LeftClick") and filled and game.selected_box == null:
		game.selected_box = self
		return
	

