extends TextureButton

class_name MainMenuButton

export(String) var buttonName

onready var tween = get_node("Tween")
onready var text = get_node("RichTextLabel")

func _ready():
	self.text.bbcode_text = self.buttonName

func _on_mouse_entered():
	self.tween.interpolate_property(self, "rect_position:x",
		self.rect_position.x, 0, .5,
		Tween.TRANS_QUAD, Tween.EASE_OUT)
	self.tween.start()

func _on_mouse_exited():
	self.tween.interpolate_property(self, "rect_position:x",
		self.rect_position.x, -50, .5,
		Tween.TRANS_QUAD, Tween.EASE_OUT)
	self.tween.start()

func _on_pressed():
	pass
