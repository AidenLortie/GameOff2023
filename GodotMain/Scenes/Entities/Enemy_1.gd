extends CharacterBody2D


const SPEED = 300.0

@onready var playerDetection = $"PlayerDetectionArea"

var moving = false
var chasing = false

var damageCheck = 0


func _physics_process(delta):
	var randMoving = randi_range(0,1000)
	if 990 < randMoving and moving == false or chasing == true:
		if playerDetection.has_overlapping_bodies():
			var playerDetect = playerDetection.get_overlapping_bodies()
			if playerDetect.size() > 0 :
				var playerPosition = playerDetect[0].position
				var playerOffset = playerPosition - self.position
				var playerDist = self.position.distance_to(playerPosition)

				velocity.x = move_toward(velocity.x, playerOffset.x * 2.5, 50)
				velocity.y = move_toward(velocity.y, playerOffset.y * 2.5, 50)
				
				if abs(playerDist) < 15:
					velocity.x = move_toward(velocity.x, 0, 50)
					velocity.y = move_toward(velocity.y, 0, 50)
					
				if velocity.x > 90:
					velocity.x = 75
				
				if velocity.y > 90:
					velocity.y = 75
					
				chasing = true
		else:
			velocity.x = move_toward(velocity.x, randi_range(-75,75), 150)
			velocity.y = move_toward(velocity.y, randi_range(-75,75), 150)
			chasing = false
			moving = true
		
	elif 990 < randMoving and moving == true:
		velocity.x = move_toward(velocity.x, 0, 150)
		velocity.y = move_toward(velocity.y, 0, 150)
		moving = false
		
		
	if damageCheck >= 10:
		if playerDetection.has_overlapping_bodies():
			var playerDetect = playerDetection.get_overlapping_bodies()
			if playerDetect.size() > 0 :
				var player = playerDetect[0]
				var playerDist = self.position.distance_to(player.position)
				player.playerHealth -= 10
				print(player.playerHealth)
		damageCheck = 0
	else:
		damageCheck += 1*delta
				
	

	move_and_slide()


