extends Node3D

func _ready():
	$CPUParticles3D.emitting = true
	await get_tree().create_timer(1.5).timeout
	queue_free()
	pass
