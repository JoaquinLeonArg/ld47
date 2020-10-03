extends TextureProgress

onready var tween = get_node("Tween")

func _on_Player_hp_change(hp):
	self.tween.interpolate_property(self, "value",
		self.value, hp, 1,
		Tween.TRANS_QUAD, Tween.EASE_OUT)
	self.tween.start()

