extends Control

@onready var score_label = $Panel/Label


func _process(delta: float) -> void:
	update_score()

func update_score():
	score_label.text = "Score: "+str(GameManager.score)



func _on_button_button_down() -> void:
	get_tree().reload_current_scene() 
