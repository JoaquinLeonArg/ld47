extends KinematicBody2D

class_name Player

onready var animationPlayer = get_node("AnimationPlayer")

signal hp_change(hp)
signal food_change(food)
signal mystical_change(points)

const JUMP_TIME = 16
const INTERACT_MAX_DIST = 80

export(float) var moveSpeed = 500
export(int) var maxHp = 100

var moveDirection = Vector2.ZERO
var knockback = Vector2.ZERO
var active = true
var jumpTime = 0
var currentHp = maxHp
var currentFood = 100
var hungerCount = 100
var mysticalPoints = 0
var closestInteract = null

func _ready():
	pass # Replace with function body.

func _process(delta):
	self.set_tooltip_visibility(false)
	process_input()
	process_jump()
	process_knockback()
	process_hunger()
	process_berries()

func _physics_process(delta):
	process_movement()

func process_input():
	if !self.active or self.currentHp <= 0:
		return
	
	if self.closestInteract != null and Input.is_action_just_pressed("use"):
		self.closestInteract.interact(self)
	
	if self.moveDirection != Vector2.ZERO or self.animationPlayer.is_playing():
		return
		
	if Input.is_action_pressed("ui_left"):
		self.moveDirection += Vector2(-1, 0)
		self.jumpTime = JUMP_TIME
		self.animationPlayer.play("Left")
	elif Input.is_action_pressed("ui_right"):
		self.moveDirection += Vector2(1, 0)
		self.jumpTime = JUMP_TIME
		self.animationPlayer.play("Right")
	if Input.is_action_pressed("ui_up"):
		self.moveDirection += Vector2(0, -1)
		self.jumpTime = JUMP_TIME
		self.animationPlayer.play("Back")
	elif Input.is_action_pressed("ui_down"):
		self.moveDirection += Vector2(0, 1)
		self.jumpTime = JUMP_TIME
		self.animationPlayer.play("Front")
		
	self.moveDirection = self.moveDirection.normalized() * self.moveSpeed * Vector2(1, 0.8)

func process_movement():
	self.jumpTime = max(0, self.jumpTime - 1)
	if self.jumpTime == 0:
		self.move_and_slide(self.moveDirection + self.knockback)
	else:
		self.move_and_slide(self.knockback)

func process_jump():
	if self.jumpTime == 0:
		self.moveDirection = self.moveDirection.move_toward(Vector2.ZERO, 20)

func process_knockback():
	self.knockback = self.knockback.move_toward(Vector2.ZERO, 50)

func process_hunger():
	self.hungerCount -= 1
	if self.hungerCount == 0:
		self.hungerCount = 120
		self.get_hungry(4)

func process_berries():
	self.closestInteract = null
	var closestInteractDist = INF
	var interactables = get_tree().current_scene.get_node("Interactables")
	for interactable in interactables.get_children():
		var distance = self.global_position.distance_to(interactable.global_position)
		if distance < closestInteractDist:
			closestInteractDist = distance
			self.closestInteract = interactable
	if closestInteractDist < INTERACT_MAX_DIST and self.closestInteract != null:
		self.set_tooltip(self.closestInteract.getUse(), self.closestInteract.getUseKey())
	else:
		self.closestInteract = null

func take_damage(damage):
	if self.currentHp <= 0 and damage > 0:
		return
	self.currentHp = clamp(self.currentHp - damage, 0, self.maxHp)
	emit_signal("hp_change", self.currentHp)
	if self.currentHp <= 0:
		self.active = false

func get_hungry(food):
	self.currentFood = clamp(self.currentFood - food, 0, 100)
	emit_signal("food_change", self.currentFood)
	if self.currentFood == 0:
		self.take_damage(10)

func set_knockback(amount, direction):
	if self.currentHp <= 0:
		return
	self.knockback = direction * amount

func _on_Hitbox_area_entered(area: Area2D):
	if area.has_method("get_damage"):
		self.take_damage(area.get_damage())
	else:
		print("Error: Area has no get_damage method!")
	if area.has_method("get_knockback"):
		self.set_knockback(area.get_knockback(), area.global_position.direction_to(self.global_position).normalized())
	else:
		print("Error: Area has no get_knockback method!")


func set_tooltip(text, key):
	self.set_tooltip_visibility(true)
	self.get_node("Text").bbcode_text = "[center]" + key + ": " + text + "[/center]"

func set_tooltip_visibility(visible):
	self.get_node("Text").visible = visible

func respawn():
	self.active = true
	self.position = Vector2(0, 0)
	self.take_damage(-self.maxHp)
	self.get_hungry(-100)

func get_mystical_points(amount):
	self.mysticalPoints += amount
	emit_signal("mystical_change", self.mysticalPoints)
