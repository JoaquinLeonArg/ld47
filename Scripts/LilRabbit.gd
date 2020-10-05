extends KinematicBody2D

onready var timer = get_node("Timer")
onready var sprite = get_node("Sprite")
onready var player = get_tree().current_scene.get_node("Objects/Player")

export(int) var speed = 100
var targetPoint = Vector2.ZERO
var velocity = Vector2.ZERO

func _ready():
	self.sprite.frame = randi() % 3
	self.choose_next_point()
	self.timer.start(randi() % 4 + 1)

func _process(delta):
	if self.position.is_equal_approx(self.targetPoint):
		choose_next_point()
	self.velocity = self.velocity.move_toward(Vector2.ZERO, 0.05)
	
	if self.velocity.x >= 0 and self.velocity.length() > 1:
		self.sprite.flip_h = true
	elif self.velocity.x < 0 and self.velocity.length() > 1:
		self.sprite.flip_h = false
		
	if self.player.position.y < self.position.y:
		self.z_index = 1
	else:
		self.z_index = -1

func _physics_process(delta):
	self.move_and_slide(self.velocity)

func choose_next_point():
	var angle = randi() % 360
	self.targetPoint = Vector2(3000, 0) + Vector2(300*sin(angle), 300*cos(angle))
	self.velocity = (self.position.direction_to(self.targetPoint) * self.speed)

func _on_Timer_timeout():
	self.choose_next_point()
