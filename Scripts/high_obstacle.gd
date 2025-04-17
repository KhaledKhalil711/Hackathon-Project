extends Node2D
var random_index = randi() % GameManager.images_obstacles.size()
var symbol = GameManager.images_obstacles[random_index]
var key = GameManager.images_obstacles.find_key(symbol)


func _ready() -> void:
	get_node("Symbol").texture = symbol
	print("The obstacle for the third obstacle is: ",key)
	

func _on_passthrough_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("The following object has entered the area: ", body) # Replace with function body.
		GameManager.keys_stored.append(key)
		print(GameManager.keys_stored)
