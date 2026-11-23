extends Node2D
@export var bullet_scene: PackedScene
@export var speedX: float = 500
@export var speedY: float = 500
@export var rep: float = 15

func _ready() -> void:
	for i in range(rep):
		_spawn_bullet()
		await get_tree().create_timer(1).timeout
	
	
func _spawn_bullet():
	var bullet = bullet_scene.instantiate()
	add_child(bullet)
	bullet.position = Vector2.ZERO
	if bullet.position.x > 568:
		remove_child(bullet)
