extends TextureProgress

onready var tween = get_node("Tween")

func _on_Player_food_change(food):
	self.tween.interpolate_property(self, "value",
		self.value, food, 2,
		Tween.TRANS_QUAD, Tween.EASE_OUT)
	self.tween.start()

