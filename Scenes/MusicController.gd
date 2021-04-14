extends Node2D

var battle_music = load("res://Autoloads/Soundtrack/welcome_horizons.wav")

func _ready():
	pass # Replace with function body.

func play_music():
	$Music.stream = battle_music
	$Music.play()

func stop_music():
	$Music.stream = battle_music
	$Music.stop()
