extends Area2D
@onready var animationplayer = $"../AnimationPlayer"

func _ready() -> void:
	self.body_entered.connect(GameManager.on_portal_entered)
	animationplayer.play("idle")
	
	
