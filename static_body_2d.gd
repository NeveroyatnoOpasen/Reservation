extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_StaticBody2D_body_entered(body):
	var player = $"../Player"
	if body.name == "Player":
		player.health -= 20
		
