extends KinematicBody2D

#Player Stats
var score: int = 0
var health: int = 3

#Player Physics
var gravity: int = 800
var jumpForce: int = 55
var speed: int = 200

var vel: Vector2 = Vector2()
var grounded: bool = true

#Player Components
onready var sprite = $Sprite
onready var animate = $Sprite/AnimationPlayer
onready var cam = $Camera2D
onready var sfx = $JumpSFX
onready var presentSFX = $PresentSFX
onready var ui = get_node("/root/Test Level/CanvasLayer/UI")

#Audio Componets
var jumpSFX: bool = true

func _physics_process(delta):
	vel.x = 0
	
	#Moves Player Left and Right
	if Input.is_action_pressed("move_left"):
		vel.x -= speed
	if Input.is_action_pressed("move_right"):
		vel.x += speed
		
	#Checks to See if Player is Grounded
	if is_on_floor():
		grounded = true
	elif !is_on_floor():
		coyote()
	
	#Initiates Player Movements
	vel = move_and_slide(vel, Vector2.UP)
	
	#Gravity
	vel.y += gravity * delta
	
	#Player Jump
	if Input.is_action_pressed("jump"):
		if grounded:
			vel.y -= jumpForce
			if jumpSFX:
				sfx.play()
				jumpSFX = false
			
	#Resets Level (Testing Purposes)
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	
	#Orients Sprites Correctly
	if vel.x > 0:
		sprite.flip_h = false
	if vel.x < 0:
		sprite.flip_h = true
		
	animation()
	
#Animates Player
func animation():
		if !is_on_floor():
			animate.play("Jump")
		elif is_on_floor() and vel.x != 0:
			animate.play("Walking")
		else:
			animate.play("Idle")

#Collects Presents
func collect_present(value):
	presentSFX.play()
	score += value
	ui.set_score_text(score)

#Coyote Time
func coyote():
	yield(get_tree().create_timer(.1),"timeout")
	grounded = false
	jumpSFX = true
	
