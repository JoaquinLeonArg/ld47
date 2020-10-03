extends Camera2D

export(NodePath) var trackedObject

func _ready():
	pass # Replace with function body.

func _process(delta):
	if trackedObject:
		self.position = get_node(trackedObject).position
