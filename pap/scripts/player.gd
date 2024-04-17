extends CharacterBody2D
var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 500
var player_alive = true

var attack_ip = false

const SPEED = 40.0
var current_dir = "none"

var attack_one = false

@onready var death_var = $CanvasLayer2/Death

func _ready():
	$AnimatedSprite2D.play("front_idle")

func _process(delta):
	player_movement(delta)
	move_and_slide()
	enemy_attack()
	attack()
	
	if health <= 0:
		print("Player Defeated")
		$"AnimatedSprite2D".visible = false
		$"CanvasLayer2/Death".visible = true
		health = 100

@warning_ignore("unused_parameter")
func player_movement(delta):
	if Input.is_action_pressed("Direita"):
		current_dir = "right"
		play_anim(1)
		velocity.x = SPEED
		velocity.y = 0
	elif Input.is_action_pressed("Esquerda"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("Baixo"):
		current_dir = "down"
		play_anim(1)
		velocity.y = SPEED
		velocity.x = 0
	elif Input.is_action_pressed("Cima"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -SPEED
		velocity.x = 0
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	if !attack_one:
		if dir == "right":
			anim.flip_h = true
			if movement == 1:
				anim.play("side_walk")
			elif movement == 0:
				if attack_ip == false:
					anim.play("side_idle")
		elif dir == "left":
			anim.flip_h = false
			if movement == 1:
				anim.play("side_walk")
			elif movement == 0:
				if attack_ip == false:
					anim.play("side_idle")
		elif dir == "down":
			anim.flip_h = true
			if movement == 1:
				anim.play("front_walk")
			elif movement == 0:
				if attack_ip == false:
					anim.play("front_idle")
		elif dir == "up":
			anim.flip_h = false
			if movement == 1:
				anim.play("back_walk")
			elif movement == 0:
				if attack_ip == false:
					anim.play("back_idle")


func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false
		
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health = health - 50
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)

func death():
	death_var.TogglePaused()


func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func attack():
	var dir = current_dir
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		attack_ip = true
		attack_one = true
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		elif dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		elif dir == "down":
			$AnimatedSprite2D.play("front_attack")
			$deal_attack_timer.start()
		elif dir == "up":
			$AnimatedSprite2D.play("front_attack")
			$deal_attack_timer.start()
		attack_one = false

##Isto não tá a correr bem
##Desculpa eu sou burro 👌
func _on_deal_attack_timer_timeout():
	print ("asd")
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false
	
func player():
	pass
