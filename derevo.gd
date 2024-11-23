extends Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
var alive = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_death_body_entered(body):
	if body.name == "Player":
		death()
 
func death():
	alive = false
	queue_free()


func _on_death_2_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		body.health -= 3
		death()
