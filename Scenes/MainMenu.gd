extends Control


func _ready():
	MusicMenu.start_music() #memainkan musik
	pass


func _on_menuNewGame_pressed(): #saat ditekan tombol
	get_tree().change_scene("res://Main.tscn") #nyambung ke scene Main
	MusicMenu.end_music() #memberhentikan musik


#func _on_menuLeaderboard_pressed():
	#pass # Replace with function body.


func _on_menuDLC_pressed(): #saat ditekan tombol
	get_tree().change_scene("res://Scenes/DLCsector.tscn") #nyambung ke scene DLC
	MusicMenu.end_music() #memberhentikan musik


func _on_menuExit_pressed(): #saat ditekan tombol
	get_tree().quit() #keluar permainan
