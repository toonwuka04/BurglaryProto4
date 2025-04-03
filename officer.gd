extends CharacterBody2D

@export var officer: CharacterBody2D
@export var SPEED: int = 1
@export var CHASE_SPEED: int = 150

@onready var sprite: Sprite2D = $Sprite2D
@onready var ray_cast: RayCast2D = $Sprite2D/RayCast2D
@onready var tiemr = $Timer

var direction: Vector2
var top_bounds: Vector2
var bottom_bounds: Vector2

enum States{
	WANDER
}

var current_state = States.WANDER

func _ready():
	top_bounds = self.position + Vector2(0, -105)
	bottom_bounds = self.position + Vector2(0, 105)

# const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	handle_movement(delta)
	change_direction()
	look_for_player()
	
func look_for_player():
	# kill player when in line of sight
	pass
	

func handle_movement(delta: float) -> void:
	if current_state == States.WANDER:
		velocity = velocity.move_toward(direction * SPEED, delta)	
			
	move_and_slide()

func change_direction() -> void:
	#if current_state == States.WANDER:
	if sprite.flip_v:
		# moving up and down
		if self.position.y <= bottom_bounds.y:
			direction = Vector2(0, 1)
		else:
			sprite.flip_v = false
			ray_cast.target_position = Vector2(0, -105)
	else:
		if self.position.y >= top_bounds.y:
			direction = Vector2(0, -1)
		else:
			sprite.flip_v = true
			ray_cast.target_position = Vector2(0, 105)

func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
#	# Add the gravity.
#	if not is_on_floor():
#		velocity += get_gravity() * delta

	# Handle jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction := Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)

#	move_and_slide()



func _on_timer_timeout() -> void:
	current_state = States.WANDER
