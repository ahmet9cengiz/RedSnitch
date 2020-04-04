extends Spatial

var redSnitch = preload("res://scenes/redSnitch.tscn")
onready var snitch_container = $snitchContainer



func _ready():
	$"/root/global".connect("snitch_catched", self, "_on_snitch_catched")
	$"/root/global".connect("game_over", self, "_on_game_over")
	set_process(true)

func _on_snitch_catched(body):
	$"/root/global".score += 1
	body.randomizeLocation()
	var snitch = redSnitch.instance()
	snitch.randomizeLocation()
	snitch_container.add_child(snitch)

func _on_game_over():
	get_tree().change_scene("res://scenes/gameOver.tscn")