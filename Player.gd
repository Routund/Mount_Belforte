extends CharacterBody2D

var speed = 300


func _physics_process(_delta):
	var direction = Vector2()
	if Input.is_action_pressed("move_up"):
		direction += Vector2(0,-1)
	if Input.is_action_pressed("move_down"):
		direction += Vector2(0,1)
	if Input.is_action_pressed("move_left"):
		direction += Vector2(-1,0) 
	if Input.is_action_pressed("move_right"):
		direction += Vector2(1,0)
		
	velocity = direction * speed
	
	move_and_slide()
