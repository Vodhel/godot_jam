extends CharacterBody2D


@export var speed : float = 200
@export var deceleration : float = 5
@export var acceleration : float = 25

@onready var raycast = $RayCast2D

var aim_direction = Vector2(0,-1);
var direction : Vector2
var angle : float = 0
func _ready() -> void:
	$PointLight2D.visible = false
	direction = Vector2.ZERO
	
func _physics_process(_delta: float) -> void:
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("press_left", "press_right", "press_up", "press_down")

	if raycast.is_colliding():
		var target = raycast.get_collider() # A CollisionObject2D.
		print(target.name)

	var sin_angle = direction.y/direction.length()
	if(!is_nan(sin_angle)): 
		if sin_angle == 0:
			if direction.x > 0.1:
				angle = 0
			elif direction.x < -0.1 :
				print("bonjour")
				angle = -180
		else:
			angle = rad_to_deg(asin(sin_angle))
			if direction.x < 0:
				if direction.y > 0 :
					angle = 180 - angle
				else:
					angle = -180 - angle
	rotation_degrees = angle
	if direction != Vector2.ZERO :
		if direction.x < 0:
			$Sprite2D.scale.y = -1
		else :
			$Sprite2D.scale.y = 1

	if(Input.is_action_just_pressed("A")):
		print('A')
		print(direction)
		print(sin_angle)
		print(angle)

	
	direction = direction.normalized()

#	
	#if direction != aim_direction && direction != Vector2(0,0) :
		#aim_direction = direction;
	#
	#var direction_x := Input.get_axis("press_left", "press_right")
	#var direction_y := Input.get_axis("press_up", "press_down")
#
	#if(direction.x) : velocity.x = direction.x*SPEED
	#else: velocity.x = move_toward(velocity.x, 0, SPEED)
	#if(direction.y) : velocity.y = direction.y*SPEED
	#else: velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
