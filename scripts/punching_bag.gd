extends StaticBody3D


func take_damage(amount, type = 99):
	$typeDisplay.text = str(amount) + " " + str(type)
	pass
