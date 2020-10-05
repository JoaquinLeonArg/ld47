extends Interactable

export(NodePath) var upgradeUI
onready var upgradeNode = get_node(self.upgradeUI)

func interact(player):
	player.active = false
	self.upgradeNode.show()

func getUse():
	return "upgrade"
	
func getUseKey():
	return "E"
	
