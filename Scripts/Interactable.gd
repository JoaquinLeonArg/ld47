extends Node2D

class_name Interactable

onready var player = get_tree().current_scene.get_node("Player")

func _process(delta):
	if self.player.position.y < self.position.y:
		self.z_index = 10
	else:
		self.z_index = -10

func interact(player):
	return

func getUse():
	return "undefined"
	
func getUseKey():
	return "?"
