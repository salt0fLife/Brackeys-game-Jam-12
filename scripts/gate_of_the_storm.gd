extends Node3D
var one = Settings.oneUnlocked
var two = Settings.twoUnlocked
var three = Settings.threeUnlocked
@export var real = true

# Called when the node enters the scene tree for the first time.
func _ready():
	updateGraphics()
	
	pass # Replace with function body.

func updateGraphics():
	if !real:
		await get_tree().create_timer(1).timeout
		if one:
			$crown/light1.position.x = 0.5
			await get_tree().create_timer(0.5).timeout
			pass
		if two:
			$crown/light2.position.x = 0.5
			await get_tree().create_timer(0.5).timeout
			pass
		if three:
			$crown/light3.position.x = 0.5
			await get_tree().create_timer(0.5).timeout
			pass
	else:
		if one:
			$crown/light1.position.x = 0.5
			pass
		if two:
			$crown/light2.position.x = 0.5
			pass
		if three:
			$crown/light3.position.x = 0.5
			pass
		pass
	pass
	if one and two and three and real:
		openAnimation()

func openAnimation():
	$AnimationPlayer.play("open")
	pass
