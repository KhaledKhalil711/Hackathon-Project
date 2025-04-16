extends Node2D

var timer = 0
var images_obstacles = {
	0 : preload("res://Assets/enemyBlack1.png"),
	1 : preload("res://Assets/enemyBlue5.png"),
	2 : preload("res://Assets/enemyGreen3.png"),
	3 : preload("res://Assets/enemyRed4.png")
}
var keys_stored = []
var player_choice = []



func on_portal_entered(body):
	print ("Hello, you have entered by, ",body)
	get_tree().paused = true

func _process(delta: float) -> void:
	#timer += 0.2
	#print(int(timer))
	pass
	
	
