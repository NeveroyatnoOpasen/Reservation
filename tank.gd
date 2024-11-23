extends CharacterBody2D
var chase = false
var SPEED = 150
@onready var player = $"../Player"
var bullet = preload("res://bullet.tscn")
func _ready() -> void:
	shoot_speed = 1.0 / shootspeed
var alive = true
@onready var anim = $AnimatedSprite2D
@export var shootspeed = 1.0
@onready var marker = $Marker2D
@onready var shoot_speed = $shootspeedtimer
var canshoot = true
var bulletdirection = Vector2(1,0)
func shoot():
	if canshoot:
		canshoot = false
		shoot_speed.start()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity  +=  get_gravity() * delta
	var player = $"../Player"
	var direction = (player.position - self.position).normalized()
	if alive == true:
		if chase == true:
			velocity.x = direction.x * SPEED
			anim.play("run")
		else:
			velocity.x = 0
			anim.play("idle")
		if direction.x < 0:
			$AnimatedSprite2D.flip_h = true
		else: 
			$AnimatedSprite2D.flip_h = false
			
		move_and_slide()

func _on_death_body_entered(body):
	if body.name == "Player":
		death()
 
func death():
	alive = false
	anim.play("death")
	await anim.animation_finished
	queue_free()



func _on_detector_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chase = true
	
	
	


func _on_detector_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		chase = false


func _on_dz_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.health -= 1


func _on_shootspeedtimer_timeout() -> void:
	canshoot = true
func _spawn_bullet() -> void:
   
	var bullet = bullet.instantiate()
	get_parent().add_child(bullet)
	bullet.position = position
	var direction = (player.position - position).normalized()
	if direction.x > 0:
		bullet.set_direction(Vector2(1, 0)) 
	else:
		bullet.set_direction(Vector2(-1, 0))

func _on_sz_body_entered(body: Node2D) -> void:
	_spawn_bullet()

	
