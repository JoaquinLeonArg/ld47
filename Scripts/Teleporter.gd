extends Interactable

export(Vector2) var targetPos

func interact(player):
	player.position = targetPos

func getUse():
	return "enter"
	
func getUseKey():
	return "E"
