extends Node2D

var timer = 0


func on_portal_entered(body):
	print ("Hello, you have entered by, ",body)
	get_tree().paused = true

func _process(delta: float) -> void:
	#timer += 0.2
	#print(int(timer))
	pass
	
	
