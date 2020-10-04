extends Control

export(NodePath) var player

onready var playerNode = get_node(player)

func _process(delta):
	if playerNode.active and Input.is_action_just_pressed("debug"):
		playerNode.active = false
		self.visible = true
	elif !playerNode.active and self.visible and Input.is_action_just_pressed("debug"):
		playerNode.active = true
		self.visible = false
