extends CharacterBody2D

@export var thief: CharacterBody2D
@export var SPEED: int = 100
@export var CHASE_SPEED: int = 150

@onready var sprite: Sprite2D = $Sprite2D
@onready var timer = $Timer

var direction: Vector2
var left_bounds: float
var right_bounds: float

enum States {
	WANDER,
	CHASE
}

var current_state = States.WANDER

func _ready():
	var patrol_range = 200  # how far to walk left/right from start
	thief = $"../Thief"

	left_bounds = position.x - patrol_range
	right_bounds = position.x + patrol_range

	direction = Vector2(-1, 0)
	sprite.flip_h = true

	$Flashlight/CollisionShape2D/Sprite2D.modulate.a = 0.5

func _physics_process(delta: float) -> void:
	handle_movement(delta)
	if current_state == States.WANDER:
		change_direction()

func handle_movement(delta: float) -> void:
	if current_state == States.WANDER:
		velocity = direction * SPEED
		position.x = clamp(position.x, left_bounds, right_bounds)
	elif current_state == States.CHASE:
		if thief == null:
			print("🚨 Thief is null!")
			return
		var to_thief = (thief.global_position - global_position)
		if to_thief.length() > 1000:
			print("Chase vector too long! Something's wrong.")
			return
		velocity = to_thief.normalized() * CHASE_SPEED
		sprite.flip_h = to_thief.x < 0
			
	move_and_slide()
	

func change_direction() -> void:
	if direction.x > 0 and position.x >= right_bounds:
		direction = Vector2(-1, 0)
		sprite.flip_h = true
	elif direction.x < 0 and position.x <= left_bounds:
		direction = Vector2(1, 0)
		sprite.flip_h = false

	
func start_chase():
	current_state = States.CHASE

func _on_timer_timeout() -> void:
	current_state = States.WANDER


func _on_flashlight_body_entered(body: Node2D) -> void:
	#print("Body entered:", body.name)
	#print("Thief ref:", thief)
	#if body == thief:
		#print("✅ Thief detected, starting chase!")
		#start_chase()
	get_tree().change_scene_to_file("res://InnerMusuem.tscn")
	#pass # Replace with function body.
