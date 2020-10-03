extends Area2D

export(int) var damage = 10
export(int) var knockback = 100

func get_damage():
	return self.damage

func get_knockback():
	return self.knockback
