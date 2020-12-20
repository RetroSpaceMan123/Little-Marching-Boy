extends Camera2D

onready var player = get_node("/root/Test Level/Player")

func _process (delta):
	position.x = player.position.x
	position.y = player.position.y
