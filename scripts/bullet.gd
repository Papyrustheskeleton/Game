extends Area2D
@export var damage: float = 5
@export var velocity: Vector2


func _physics_process(delta: float) -> void:
	position += velocity


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.health -= damage
