extends CharacterBody2D
var alive = true
var health = 2

const SPEED = 200
const JUMP_VELOCITY = -300
@onready var anim = get_node("AnimatedSprite2D")
@onready var sh = $shieldd/sh
@onready var col = $shieldd/col
var shie_active = false
func _process(delta):
	if Input.is_action_just_pressed("shield"):
		toggle_barrier()
func toggle_barrier():
	shie_active = !shie_active
	if shie_active:
		sh.visible = true
		col.disabled = false
		sh.play("shiel")
	else:
		sh.visible = false
		col.disabled = true
		

func _ready():
	connect("body_entered", Callable  (self, "_on_shieldd_body_entered"))
enum{
	idle,
	run,
	attack1,
	attack2,
	shield
}
var state = run
func _physics_process(delta: float) -> void:
	match state:
		idle:
			pass
		attack1:
			pass
		attack2:
			pass
		shield:
			block_state()
		run:
			move_state()
	# Add the gravity.
	if not is_on_floor():
		velocity  +=  get_gravity() * delta
	if alive == true:

		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			anim.play("jump")

		if velocity.y > 0 :
			anim.play("fall")
		if health <= 0:
			health = 0
			alive = false
			anim.play("death")
			await anim.animation_finished
			queue_free()
			get_tree().change_scene_to_file("res://menu.tscn")
	move_and_slide()

func move_state():
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("idle")
	if direction == -1:
			$AnimatedSprite2D.flip_h = true
	elif direction == 1:
			$AnimatedSprite2D.flip_h = false
	if Input.is_action_just_pressed("shield"):
		state = shield
func block_state():
	anim.play("shield")
	if Input.is_action_just_released("shield"):
		state = run
		
	


func _on_shieldd_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet"):
		body.queue_free()
