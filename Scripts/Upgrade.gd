extends Control

class_name Upgrade

export(String) var title
export(String) var description
export(int) var cost
export(Array, NodePath) var unlocks

var floatingTextNode = preload("res://Objects/FloatingText.tscn")

onready var titleNode = get_node("Title")
onready var descriptionNode = get_node("Description")
onready var descriptionShadowNode = get_node("DescriptionShadow")
onready var costNode = get_node("Cost")
onready var failSound = get_node("Fail")
onready var successSound = get_node("Success")

func _ready():
	self.titleNode.bbcode_text = self.title
	self.descriptionNode.bbcode_text = self.description
	self.descriptionShadowNode.bbcode_text = self.description
	self.costNode.bbcode_text = "[center] " + String(self.cost) + " [/center]"

func upgrade(player: Player):
	if player.mysticalPoints < self.cost:
		self.failSound.play()
		if !self.has_node("FloatingText"):
			var errorNode = self.floatingTextNode.instance()
			errorNode.set_text("Not enough points!")
			errorNode.rect_position.x += 50
			self.add_child(errorNode)
		return
	self.successSound.play()
	player.get_mystical_points(-self.cost)
	for unlock in self.unlocks:
		get_node(unlock).disabled = false
	self.disabled = true
	self.concrete_upgrade(player)
	
func concrete_upgrade(player):
	pass

func _on_Upgrade_pressed():
	self.upgrade(get_tree().current_scene.get_node("Objects/Player"))
	
