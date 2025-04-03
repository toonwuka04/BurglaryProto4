extends CharacterBody2D

@export var thief: CharacterBody2D
@export var SPEED: int = 100
@export var CHASE_SPEED: int = 150

@onready var sprite: Sprite2D = $Sprite2D
@onready var tiemr = $Timer

var direction: Vector2
var left_bounds: float
var right_bounds: float

enum States {
	WANDER
}

var current_state = States.WANDER

func _ready():
	var patrol_range = 200  # how far to walk left/right from start

	left_bounds = position.x - patrol_range
	right_bounds = position.x + patrol_range

	direction = Vector2(-1, 0)
	sprite.flip_h = true

	$Flashlight/CollisionShape2D/Sprite2D.modulate.a = 0.5

func _physics_process(delta: float) -> void:
	handle_movement(delta)
	change_direction()
	look_for_player()

func handle_movement(delta: float) -> void:
	if current_state == States.WANDER:
		velocity = direction * SPEED
			
	move_and_slide()
	position.x = clamp(position.x, left_bounds, right_bounds)

func change_direction() -> void:
	if direction.x > 0 and position.x >= right_bounds:
		direction = Vector2(-1, 0)
		sprite.flip_h = true
	elif direction.x < 0 and position.x <= left_bounds:
		direction = Vector2(1, 0)
		sprite.flip_h = false

func look_for_player():
	pass

func _on_timer_timeout() -> void:
	current_state = States.WANDER
