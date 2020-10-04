extends Interactable

onready var sprite = get_node("ObeliskSprite")

export(int) var replenishTime = 300

var timeUntilReplenish = replenishTime
var hasCharges = true

func _process(delta):
	._process(delta)
	if self.timeUntilReplenish > 0 and !self.hasCharges:
		self.timeUntilReplenish -= 1
	elif self.timeUntilReplenish == 0 and !self.hasCharges:
		self.hasCharges = true
		self.sprite.frame = 1
		self.timeUntilReplenish = self.replenishTime

func interact(player):
	if !self.hasCharges:
		return
	self.hasCharges = false
	self.timeUntilReplenish = self.replenishTime
	self.sprite.frame = 0
	player.get_mystical_points(randi() % 1 + 1)

func getUse():
	return "activate"
	
func getUseKey():
	return "E"
	
