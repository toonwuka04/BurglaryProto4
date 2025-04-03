extends CharacterBody2D

@export var thief: CharacterBody2D
@export var SPEED: int = 5
@export var CHASE_SPEED: int = 150

@onready var sprite: Sprite2D = $Sprite2D
@onready var tiemr = $Timer

var direction: Vector2
var left_bounds: Vector2
var right_bounds: Vector2

enum States{
	WANDER
}

var current_state = States.WANDER

func _ready():
	left_bounds = Vector2(337, 0)
	right_bounds = Vector2(550, 0)
	direction = Vector2(1, 0)
	$Flashlight/CollisionShape2D/Sprite2D.modulate.a = 0.5

# const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	handle_movement(delta)
	change_direction()
	look_for_player()
	
func look_for_player():
	# kill player when in line of sight
	pass
	

func handle_movement(delta: float) -> void:
	if current_state == States.WANDER:
		velocity = direction * SPEED	
			
	move_and_slide()

func change_direction() -> void:
	#if current_state == States.WANDER:
	if sprite.flip_h:
		# moving right
		if self.position.x <= right_bounds.x:
			direction = Vector2(1, 0) # continue right
		else:
			sprite.flip_h = false
			#ray_cast.target_position = Vector2(-136, 0)
	else:
		if self.position.x >= left_bounds.x:
			direction = Vector2(-1, 0) # continue left
		else:
			sprite.flip_h = true
			#ray_cast.target_position = Vector2(136, 0)


func _on_timer_timeout() -> void:
	current_state = States.WANDER
