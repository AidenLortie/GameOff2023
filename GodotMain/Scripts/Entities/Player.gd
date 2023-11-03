extends CharacterBody2D


const SPEED = 100.0

@onready var walkAnim = $"Sprite2D/AnimationPlayer/WalkAnimTree"
@onready var idleAnim = $"Sprite2D/AnimationPlayer/IdleAnimTree"

func _ready():
	walkAnim.set("parameters/blend_position", [0,0])
	idleAnim.set("parameters/blend_position", [0,0])

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionx = Input.get_axis("ui_left", "ui_right")
	if directionx:
		velocity.x = directionx * SPEED

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var directiony = Input.get_axis("ui_up", "ui_down")
	if directiony:
		velocity.y = directiony * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if velocity:
		idleAnim.set("active", false)
		walkAnim.set("active", true)
	else:
		idleAnim.set("active", true)
		walkAnim.set("active", false)
		
	walkAnim.set("parameters/blend_position", velocity)
	idleAnim.set("parameters/blend_position", velocity)

	move_and_slide()
