extends Control

onready var mountainsBg = get_node("TextureRect")
onready var mountainsBg2 = get_node("TextureRect2")

func _process(delta):
	var currentX = mountainsBg.get_material().get_shader_param("x")
	var currentX2 = mountainsBg2.get_material().get_shader_param("x")
	mountainsBg.get_material().set_shader_param("x", currentX + 0.0003)
	mountainsBg2.get_material().set_shader_param("x", currentX2 + 0.0006)
