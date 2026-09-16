extends CharacterBody2D
@export var speedX: float = 500
@export var speedY: float= speedX
@export var wierdness:float=0
func _physics_process(_delta: float):
	var input_vector_X = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var input_vector_Y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	velocity.x = input_vector_X * speedX
	velocity.y = input_vector_Y * speedY
	move_and_slide()
