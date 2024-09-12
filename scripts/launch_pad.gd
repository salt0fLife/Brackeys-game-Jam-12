extends Node3D
@export var newVelocity := Vector3(0,0,0)
@export var disabedTime := 0.5


func _on_static_body_3d_body_entered(body):
	body.disabled = true
	body.position.y += 1
	body.velocity = newVelocity
	$AnimationPlayer.play("launch")
	await get_tree().create_timer(disabedTime).timeout
	body.disabled = false
	pass # Replace with function body.
