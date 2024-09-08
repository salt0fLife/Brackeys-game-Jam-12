extends Label3D


func set_value(value):
	text = str(value)


func _on_timer_timeout():
	queue_free()
