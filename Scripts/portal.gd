extends Area2D

func _ready() -> void:
	self.body_entered.connect(GameManager.on_portal_entered)
