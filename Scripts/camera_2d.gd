extends Camera2D

@export var target: Node2D  # Assign your player node here
@export var follow_speed: float = 0.2
@export var vertical_poisiton:float
@export var ground_position :Node2D
@export var vertical_offset : float
func _ready() -> void:
	make_current()
func _process(delta: float) -> void:
	if target:
		
		# Only follow the player's horizontal position
		position.x = lerp(position.x, target.global_position.x+300, follow_speed)
		# Maintain original vertical position (no Y-axis following)
		position.y = ground_position.global_position.y-vertical_offset
