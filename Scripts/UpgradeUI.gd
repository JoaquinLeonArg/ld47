extends Control

onready var player = get_tree().current_scene.get_node("Objects/Player")

var justActive = false

func show():
	self.visible = true
	self.justActive = true
	self.player.active = false

func _process(delta):
	if !self.visible:
		return
	if !self.justActive and self.visible and !self.player.active and Input.is_action_just_pressed("use"):
		player.active = true
		self.visible = false
	self.justActive = false
