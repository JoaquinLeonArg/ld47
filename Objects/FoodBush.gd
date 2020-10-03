extends Node2D

onready var berries = get_node("BerriesSprite")

export(int) var replenishTime = 300

var timeUntilReplenish = replenishTime
var hasBerries = true

func _process(delta):
	if self.timeUntilReplenish > 0 and !self.hasBerries:
		self.timeUntilReplenish -= 1
	elif self.timeUntilReplenish == 0 and !self.hasBerries:
		self.hasBerries = true
		self.berries.visible = true
		self.timeUntilReplenish = self.replenishTime

func eat_berries():
	self.hasBerries = false
	self.timeUntilReplenish = self.replenishTime
	self.berries.visible = false
