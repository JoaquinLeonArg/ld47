extends Control

export(NodePath) var playerNode

onready var tween = get_node("Tween")
onready var player = get_node(playerNode)

func _on_Player_hp_change(hp):
	if hp <= 0:
		self.tween.interpolate_property(self, "modulate:a",
			0, 1, 1,
			Tween.TRANS_QUAD, Tween.EASE_OUT)
		self.tween.start()

func _process(delta):
	if self.modulate.a == 1 and Input.is_action_just_pressed("use"):
		self.player.respawn()
		self.tween.interpolate_property(self, "modulate:a",
			1, 0, 1,
			Tween.TRANS_QUAD, Tween.EASE_OUT)
		self.tween.start()
