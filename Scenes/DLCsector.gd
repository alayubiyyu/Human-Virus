extends Node


func _ready():
	MusicDLC.played_music() #memainkan musik
	pass 


func _on_ch1_pressed():
	get_tree().change_scene("res://Main2.tscn") #nyambung ke scene Main2
	MusicDLC.stoped_music() #memberhentikan musik


func _on_ch4_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn") #nyambung ke scene Main Menu
	MusicDLC.stoped_music() #memberhentikan musik
