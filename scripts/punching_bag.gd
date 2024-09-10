extends StaticBody3D


func take_damage(amount, type = 99, knockback = Vector3(0,0,0)):
	$typeDisplay.text = str(amount) + " " + str(type)
	pass
