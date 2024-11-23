extends Control
func _ready():
	$AnimationPlayer.play("RESET")
	hide_pause_menu()

	
func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	hide_pause_menu()

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	show_pause_menu()

# Called when the node enters the scene tree for the first time.
func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()
	

func _on_resume_pressed() -> void:
	resume()
func show_pause_menu():
	self.visible = true
func hide_pause_menu():
	self.visible = false



func _on_quit_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://menu.tscn")
	
func _process(delta):
	testEsc()

	
func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()
