extends Node2D					
@onready var score_label = $"/root/Game/CanvasLayer/Score"
@onready var timer_label = $"/root/Game/CanvasLayer/Timer"
@onready var game_over = $"/root/Game/CanvasLayer/Game Over"
@onready var select_scene = $"/root/Game/CanvasLayer/Select_shapes"
@export var timer = 0
var player_dead = false
var score = 0
var time_remaining = 30
var images_obstacles = {
	0 : preload("res://Assets/enemyBlack1.png"),
	1 : preload("res://Assets/enemyBlue5.png"),
	2 : preload("res://Assets/enemyGreen3.png"),
	3 : preload("res://Assets/enemyRed4.png")
}
var target_array = [0,1,2,2,3]
var keys_stored = []
var player_choice = []



func on_portal_entered(body):
	print ("Hello, you have entered by, ",body)
	get_tree().paused = true
	if(is_instance_valid(select_scene)):
		select_scene.visible = true	
	

func _ready() -> void:
	timer = 0
	score = 0
	update_score()

func _process(delta: float) -> void:
	if(GameManager.player_dead == false):
		update_score()
		time_remaining -= delta
		update_timer()
	if(GameManager.player_dead == true and is_instance_valid(game_over)):
		game_over.visible = true
	

	
	
func update_score():
	timer += 0.2
	score = int(timer)
	if(is_instance_valid(score_label)):
		score_label.text = "Score: " + str(score)
	

func update_timer():
	if(is_instance_valid(timer_label)):
		timer_label.text = "Time Remaining " + str(int(time_remaining))
	
	
	
