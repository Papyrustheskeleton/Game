extends CharacterBody2D
@onready var player = $Box/player
@onready var speed: float = 400
@export var movement: bool = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left","right","up","down")
	if movement:
		velocity = direction * speed
		move_and_slide()
	if not movement:
		pass
