extends Node2D

var sad_music = load("res://Autoloads/Soundtrack/My R - Music Box Cover.wav")

func _ready():
	pass # Replace with function body.

func played_music():
	$MMMusic.stream = sad_music
	$MMMusic.play()

func stoped_music():
	$MMMusic.stream = sad_music
	$MMMusic.stop()
