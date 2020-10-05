extends Node2D

onready var tween = get_node("Tween")
onready var timer = get_node("Timer")
onready var timer2 = get_node("Timer2")

var xVelocity

func _ready():
	self.tween.interpolate_property(self, "modulate:a",
		0, 1, 0.5,
		Tween.TRANS_QUAD, Tween.EASE_IN)
	self.tween.start()

func _process(delta):
	self.position.x += xVelocity

func _on_Timer_timeout():
	self.tween.interpolate_property(self, "modulate:a",
		1, 0, 0.5,
		Tween.TRANS_QUAD, Tween.EASE_IN)
	self.tween.start()
	self.timer2.start(0.5)

func _on_Timer2_timeout():
	self.queue_free()
