extends CharacterBody2D

var speed = 700

func _ready():
	$AnimationPlayer.play("idle_down")

func _physics_process(_delta):
	var direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	velocity = direction * speed
	
	#if Input.is_action_pressed("up"):
		#direction += Vector2(0,-1)
		#$AnimationPlayer.play("walk_up")
	#if Input.is_action_pressed("down"):
		#direction += Vector2(0,1)
		#$AnimationPlayer.play("walk_down")
	#if Input.is_action_pressed("left"):
		#direction += Vector2(-1,0) 
		#$AnimationPlayer.play("walk_left")
	#if Input.is_action_pressed("right"):
		#direction += Vector2(1,0)
		#$AnimationPlayer.play("walk_right")
	#if Input.is_action_just_released("down"):
		#$AnimationPlayer.play("idle_down")
	#if Input.is_action_just_released("up"):
		#$AnimationPlayer.play("idle_up")
	#if Input.is_action_just_released("left"):
		#$AnimationPlayer.play("idle_left")
	#if Input.is_action_just_released("right"):
		#$AnimationPlayer.play("idle_right")
	
	
	move_and_slide()
	
