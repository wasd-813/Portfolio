extends "res://scripts/card_util/drop_box.gd"


func _on_gui_input(event):
	if Input.is_action_pressed("LeftClick") and filled and game.selected_box != null:
		game.process_attack(game.selected_box, self)
		return
