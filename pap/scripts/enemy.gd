extends CharacterBody2D

var speed = 60
var player_chase = false
var player = null

var health = 200
var player_inattack_zone = false

func _physics_process(delta):
	deal_with_damage()
	
	if player_chase:
		position += (player.position - position)/speed
		
		$AnimatedSprite2D.play("Walk")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
			
	else:
		$AnimatedSprite2D.play("Idle")
	Move(delta)

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

func enemy():
	pass

func Move(delta):

	if (player):
		var Goto = (player.position - position).normalized()
		move_and_slide()


func _on_enemy_hitbox_area_entered(body):
	if body.get_name().contains("Player"):
		player_inattack_zone = true
		print("asd")


func _on_enemy_hitbox_area_exited(body):
	if body.get_name().contains("Player"):
		player_inattack_zone = false
		
func deal_with_damage():
	print(global.player_current_attack)
	if player_inattack_zone and global.player_current_attack == true:
		health = health - 20
		print("slime health = ", health)
		if health <=0:
			self.queue_free()
			player_inattack_zone = false

