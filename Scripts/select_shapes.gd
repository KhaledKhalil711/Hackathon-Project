extends Control

@onready var select_shapes = $"/root/Game/CanvasLayer/Select_shapes"


func _on_first_shape_button_down() -> void:
	pressed_button(0) # Replace with function body.
	print("Button pressed")


func _on_second_shape_button_down() -> void:
	pressed_button(1) # Replace with function body.


func _on_third_shape_button_down() -> void:
	pressed_button(2) # Replace with function body.


func _on_fourth_shape_button_down() -> void:
	pressed_button(3) # Replace with function body.

func pressed_button(index):
	GameManager.player_choice.append(index)
	var length = GameManager.player_choice.size()
	if(GameManager.player_choice[length-1] == GameManager.target_array[length-1]):
		if(GameManager.player_choice.size() == GameManager.target_array.size()):
			GameManager.time_remaining += 30
			print("You got the correct sequence")
			get_tree().paused = false
			if(is_instance_valid(select_shapes)):
				select_shapes.visible = false
	else:
		print("You Lose!!!!")
		
		
