extends CharacterBody2D

var speed = 700


func _physics_process(_delta):
	print(Global.slime)
	var direction = Vector2()
	if Input.is_action_pressed("up"):
		direction += Vector2(0,-1)
	if Input.is_action_pressed("down"):
		direction += Vector2(0,1)
	if Input.is_action_pressed("left"):
		direction += Vector2(-1,0) 
	if Input.is_action_pressed("right"):
		direction += Vector2(1,0)
		
	velocity = direction * speed
	
	move_and_slide()
	
