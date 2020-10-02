extends Button

func _ready():
	pass

func on_pressed():
	Model.reset() # Start a new game
	get_tree().change_scene("res://welcome/welcome.tscn")
