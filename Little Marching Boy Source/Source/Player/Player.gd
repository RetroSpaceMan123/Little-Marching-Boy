extends KinematicBody2D

#Player Stats
var score: int = 0
var health: int = 3

#Player Physics
var gravity: int = 800
var jumpForce: int = 600
var speed: int = 200

var vel: Vector2 = Vector2()
var grounded: bool = false

#Player Components
onready var sprite = $Sprite

func _physics_process(delta):
	vel.x = 0
	
	if Input.is_action_pressed("move_left"):
		vel.x -= speed
	if Input.is_action_pressed("move_right"):
		vel.x += speed
		
	vel = move_and_slide(vel, Vector2.UP)
	
	vel.y += gravity * delta
	
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y -= jumpForce
	
	if vel.x < 0:
		sprite.flip_h = false
	if vel.x > 0:
		sprite.flip_h = true
