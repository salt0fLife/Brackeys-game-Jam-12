extends Node3D
var out = false

func _ready():
	if randi_range(0, 1) == 1 or !Settings.hasSeenFG:
		$FunnyGuy/AnimationPlayer.play("idleOut")
		out = true
		pass
	else:
		$FunnyGuy/AnimationPlayer.play("Hide")
	pass

func _on_area_3d_body_entered(body):
	if out:
		Settings.hasSeenFG = true
		$FunnyGuy/AnimationPlayer.play("gettaWay")
		out = false
	pass # Replace with function body.


func _on_area_3d_body_exited(body):
	if randi_range(0, 5) == 5:
		$FunnyGuy/AnimationPlayer.play("PeekOutAndLook")
	
	
	pass # Replace with function body.


func _on_timer_timeout():
	if randi_range(0, 10) == 10:
		var current = $FunnyGuy/AnimationPlayer.get_current_animation()
		if current != "gettaWay" and current != "PeekOutAndLook":
			$FunnyGuy/AnimationPlayer.play("")
		pass
	pass # Replace with function body.
