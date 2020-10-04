extends Control

class_name Upgrade

export(String) var title
export(String) var description
export(int) var cost
export(Array, NodePath) var unlocks

onready var titleNode = get_node("Title")
onready var descriptionNode = get_node("Description")
onready var descriptionShadowNode = get_node("DescriptionShadow")
onready var costNode = get_node("Cost")

func _ready():
	self.titleNode.bbcode_text = self.title
	self.descriptionNode.bbcode_text = self.description
	self.descriptionShadowNode.bbcode_text = self.description
	self.costNode.bbcode_text = "[center] " + String(self.cost) + " [/center]"

func upgrade(player: Player):
	if player.mysticalPoints < self.cost:
		return
	for unlock in self.unlocks:
		get_node(unlock).disabled = false
	self.disabled = true

func _on_Upgrade_pressed():
	self.upgrade(get_tree().current_scene.get_node("Player"))
	
