extends KinematicBody2D

#Player Stats
var score: int = 0
var health: int = 3

#Player Physics
var gravity: int = 800
var jumpForce: int = 60
var speed: int = 200

var vel: Vector2 = Vector2()
var grounded: bool = true

#Player Components
onready var sprite = $Sprite
onready var animate = $Sprite/AnimationPlayer
onready var cam = $Camera2D
onready var coytime = $"Coyote Time"
onready var ui = get_node("/root/Test Level/CanvasLayer/UI")

func _physics_process(delta):
	vel.x = 0
	
	if Input.is_action_pressed("move_left"):
		vel.x -= speed
	if Input.is_action_pressed("move_right"):
		vel.x += speed
		
	if !is_on_floor():
		coytime.start()
		
		
	if coytime.is_stopped():
		grounded = false
	
	
	vel = move_and_slide(vel, Vector2.UP)
	
	vel.y += gravity * delta
	
	
	if Input.is_action_pressed("jump") and grounded:
		vel.y -= jumpForce
	
	if vel.x > 0:
		sprite.flip_h = false
	if vel.x < 0:
		sprite.flip_h = true
		
	animation()
	
func animation():
		if vel.x != 0:
			animate.play("Walking")
		else:
			animate.play("Idle")

func collect_present(value):
	score += value
	ui.set_score_text(score)
