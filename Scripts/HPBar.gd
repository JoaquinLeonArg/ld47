extends TextureProgress

onready var tween = get_node("Tween")
onready var text = get_node("HPText")
onready var player = get_tree().current_scene.get_node("Objects/Player")

func _on_Player_hp_change(hp):
	self.tween.interpolate_property(self, "value",
		self.value, hp, 1,
		Tween.TRANS_QUAD, Tween.EASE_OUT)
	self.tween.start()
	self.max_value = self.player.maxHp
	text.bbcode_text = "[center]" + String(hp) + " / " + String(self.player.maxHp)  + "[/center]"

