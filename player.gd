extends KinematicBody2D

var speed = 300
var jump_speed = -1500
var gravity = 4000
var motion = Vector2()
  

func _physics_process(delta):
	
					  #--- movements ---#
	
	# When the right arrow key is pressed, and is NOT on wall:
	if Input.is_action_pressed("right") and !is_on_wall(): 
		  
		motion.x = speed                              #---> move to the right.
		$AnimatedSprite.play("move_right")            #---> Right movement animation.
		
		
	# When the right arrow key is pressed, and is on wall or the wall_right function becomes true:
	elif Input.is_action_pressed("right") and is_on_wall() or wall_right():   
		
		motion.x = speed                              #---> move to the right.
		$AnimatedSprite.play("wall_slide_right")      #---> light slight_movement animation.
		
		

	# When the left arrow key is pressed, and is NOT on wall:
	elif Input.is_action_pressed("left") and !is_on_wall():  
		 
		motion.x = -speed                             #---> move to the left.
		$AnimatedSprite.play("move_left")             #---> left movement animation.
		
		
	# When the left arrow key is pressed, and is on wall or the wall_left function becomes true:
	elif Input.is_action_pressed("left") and is_on_wall() or wall_left():
		
		motion.x = -speed                             #---> move to the left.
		$AnimatedSprite.play("wall_slide_left")       #---> left slight_movement animation.
		
		
	# If no key is pressed:
	else:
		motion.x = 0                                  #---> don't move.
		$AnimatedSprite.play("standing")              #---> Standing movement animation.
	
	
	# when the jump button is pressed:
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():                             #---> only when the player is on floor:
			motion.y = jump_speed                     #---> do jump.
		
		
		
		
		
					   #-----when player is on the left wall-----#
	
	if wall_left(): #---> if raycast is true (has contact with a wall)
		motion.y = speed * delta #---> slide down the wall, with speed of 
								 #     the variable speed (which is 300)
		
		# if function wall_left becomes true, and, jump key is pressed, and, right key is pressed:
		#          (in other words---> if you jump from one wall to another wall)
		if wall_left() and Input.is_action_pressed("jump") and Input.is_action_pressed("right"):
			motion.x = 1300   #---> speed in x
			motion.y = -1500  #---> speed in y
			
			
		# if you press right, without jumping--> you falling from wall.
		elif Input.is_action_pressed("right"):    
			motion.x = speed
			
			
					  #-----when player is on the right wall-----#
	
	if wall_right(): #---> if raycast is true (has contact with a wall)
		motion.y = speed * delta  #---> slide down the wall, with speed of
								  #     the variable speed (which is 300)
		
		
		# if function wall_right becomes true, and, jump key is pressed, and, left key is pressed:
		#          (in other words---> if you jump from one wall to another wall)
		if wall_right() and Input.is_action_pressed("jump") and Input.is_action_pressed("left"):
			motion.x = -1300 #---> speed in x
			motion.y = -1500  #---> speed in y

		# if you press left, without jumping--> you falling from wall.
		elif Input.is_action_pressed("left"): 
			motion.x = -speed
		
		
		
	#--- Gravity ---#
	motion.y += gravity * delta #---> time delta means--> per second. So, here we say: 
								#     move the player postion, 
								#     4000 pixels per second in the y+ direction.
	
	motion = move_and_slide(motion, Vector2.UP)
	

#---> with this function we say, when the ray cast: ray_cast_left_wall, has detected a wall,
#     than, it returns this information.
func wall_left():
	return $ray_cast_left_wall.is_colliding()


#---> with this function we say, when the ray cast: ray_cast_right_wall, has detected a wall,
#     than, it returns this information.
func wall_right():
	return $ray_cast_right_wall.is_colliding()




