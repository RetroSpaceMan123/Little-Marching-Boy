extends Area2D

export var value = 1


func _on_Present_body_entered(body):
		
		if body.name == "Player":
			body.collect_present(value)
			queue_free()
