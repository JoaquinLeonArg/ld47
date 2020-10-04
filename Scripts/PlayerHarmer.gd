extends Area2D

export(int) var damage = 10
export(int) var knockback = 100
export(float) var radius = 10

func _ready():
	get_node("CollisionShape2D").shape.radius = self.radius

func get_damage():
	return self.damage

func get_knockback():
	return self.knockback
