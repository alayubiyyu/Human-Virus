extends Node

var menu_song = load("res://Autoloads/Soundtrack/ez4ence_the_verkkars.wav")

func _ready():
	pass # Replace with function body.

func start_music():
	$MMusic.stream = menu_song
	$MMusic.play()

func end_music():
	$MMusic.stream = menu_song
	$MMusic.stop()
