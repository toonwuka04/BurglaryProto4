extends CharacterBody2D

const SPEED = 150.0
@onready var sprite_2d = $Sprite2D

func _physics_process(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	move_and_slide()
	update_animation(direction)

func update_animation(direction: Vector2):
	if direction == Vector2.ZERO:
		sprite_2d.animation = "neutral"
		sprite_2d.flip_h = false  
		return
	
	if abs(direction.x) > abs(direction.y):
		sprite_2d.animation = "right"
		sprite_2d.flip_h = direction.x < 0  # Flip for left 
	else:
		sprite_2d.animation = "down" if direction.y > 0 else "up"
		sprite_2d.flip_h = false  
	
	sprite_2d.play() 


func _on_area_2d_body_entered(body: Node2D) -> void:
	#get_tree().change_scene_to_file("res://InnerMusuem.tscn")
	pass # Replace with function body.
