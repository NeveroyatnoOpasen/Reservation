extends Node2D

@export var speed = 250
var direction: Vector2

func set_direction(dir: Vector2) -> void:
	direction = dir.normalized()
	rotation = direction.angle()
func _physics_process(delta):
	position += direction * speed * delta 
func _ready():
	pass
	#set_as_top_level(true)





func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.health -= 1
		queue_free()
		


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "shieldd":
		queue_free()
