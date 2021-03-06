extends CanvasLayer

func _ready():
	set_visible(false)

func _input(event):
	if event.is_action_pressed("pause"):
		$pause_popup.visible = !$pause_popup.visible
		set_visible(!get_tree().paused)
		get_tree().paused = !get_tree().paused


func _on_Button_pressed():
	$pause_popup.hide()
	get_tree().paused = false
	set_visible(false)

func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible
