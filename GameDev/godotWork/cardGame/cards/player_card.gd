# Abstract i.e. no scence instance exisits to instantiate an object
extends "res://scripts/cards/card.gd"


func _on_gui_input(event):
	if Input.is_action_pressed("LeftClick") and game.selected_card == null:
		self.try_select_card()


func _on_mouse_entered():
	if game.selected_card == null:
		animate_hover()


func _on_mouse_exited():
	if game.selected_card == null:
		animate_dehover()


# return type: void
func animate_hover():
	# only play anim if card is in hand/properly instantiated onto the scene
	if(self.position != null):
		var t = create_tween()
		var hover_offset = Vector2(0, -(Global.SCALE[1] * $Sprite.texture.get_height() / 2))
		t.tween_property($Sprite, "position", sprite_resting_pos + hover_offset, 0.2)


# return type: void
func animate_dehover():
	if(self.position != null):
		var t = create_tween()
		t.tween_property($Sprite, "position", sprite_resting_pos, 0.2)
