extends Node2D					
@onready var score_label = $"/root/Game/CanvasLayer/Score"
@onready var timer_label = $"/root/Game/CanvasLayer/Timer"
@export var timer = 0
var player_dead = false
var score
var time_remaining = 30
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
	if(GameManager.player_dead == false):
		update_score()
		time_remaining -= delta
		update_timer()
	

	
	
func update_score():
	timer += 0.2
	score = int(timer)
	score_label.text = "Score: " + str(score)
	

func update_timer():
	timer_label.text = "Time Remaining " + str(int(time_remaining))
	
	
	
