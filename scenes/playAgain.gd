extends Button

func _ready():
	pass # Replace with function body.

func _on_playAgain_pressed():
	$"/root/global".score = 0
	get_tree().change_scene("res://scenes/primaryScene.tscn")