extends KinematicBody2D

onready var animationPlayer = get_node("AnimationPlayer")
onready var timer = get_node("Timer")
onready var player = get_tree().current_scene.get_node("Objects/Player")

export(int) var speed = 100
var targetPoint = Vector2.ZERO
var velocity = Vector2.ZERO

func _ready():
	self.choose_next_point()
	self.animationPlayer.play("Left")

func _process(delta):
	if self.position.is_equal_approx(self.targetPoint):
		choose_next_point()
		self.timer.start(3)
	self.velocity = self.velocity.move_toward(Vector2.ZERO, 0.7)
	
	if self.velocity.x >= 0 and self.velocity.length() > 1:
		self.animationPlayer.play("Right")
	elif self.velocity.x < 0 and self.velocity.length() > 1:
		self.animationPlayer.play("Left")
	else:
		self.animationPlayer.stop()

func _physics_process(delta):
	self.move_and_slide(self.velocity)

func choose_next_point():
	if self.position.distance_to(Vector2(0, 0)) > 2000:
		self.targetPoint = self.position.direction_to(Vector2(0, 0))
		self.velocity = self.position.direction_to(Vector2(0, 0)) * self.speed * 3
	elif self.position.distance_to(self.player.position) < 350 * self.player.detectionRange:
		self.targetPoint = self.player.position
		self.velocity = self.position.direction_to(self.player.position) * self.speed * 1.5
	else:
		var angle = randi() % 360
		self.targetPoint = self.position + Vector2(300*sin(angle), 300*cos(angle))
		self.velocity = (self.position.direction_to(self.targetPoint) * self.speed)

func _on_Timer_timeout():
	self.choose_next_point()
