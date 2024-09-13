extends Area3D
var deathSmoke = preload("res://effects/particles/death_smoke.tscn")
var velocity = Vector3()

func _physics_process(delta):
	position += velocity * delta
	pass

func take_damage(damage, type, knockback):
	_on_timer_timeout()
	pass

func set_velocity(newVel):
	velocity = newVel
	pass

func _on_body_entered(body):
	body.take_damage(75, 1, Vector3(0, 5, 0))
	body.add_child(deathSmoke.instantiate())
	queue_free()


func _on_timer_timeout():
	var ds = deathSmoke.instantiate()
	get_parent().add_child(ds)
	ds.position = position
	queue_free()
	pass # Replace with function body.
