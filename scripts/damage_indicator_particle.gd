extends Label3D


func set_value(value):
	text = str(value)
	


func _on_timer_timeout():
	queue_free()

func _process(delta):
	position.y += delta / 5
	modulate.a -= delta
	outline_modulate.a -= delta
	
	pass
