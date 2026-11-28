extends Control
@onready var textbox = $TextBox
@onready var text = $TextBox/Text
@export var message = "ribbit"
@onready var current_turn = 0
@onready var Fight = $Fight
@onready var box = $Box
@onready var enemy = $Enemy
@onready var player = $Box/player
@export var attack1 : PackedScene
@onready var attack
@onready var fight = $Fight
@export var txt_spd = 0.01
@export var delay: float = 3
@export var enemydata:EnemyData
@onready var nameplate = $"TextBox/Dummy-name"
@onready var enemy_text = $"Enemy Health"
@onready var enemy_Hp = enemydata.Enemy_Hp
@onready var enemy_Def = enemydata.Enemy_Def
@export var player_stats:Player_Stats
@onready var player_Atk = player_stats.Atk
@onready var player_Def = player_stats.Def
@onready var dmg = player_Atk - enemy_Def
@onready var finished


func _ready() -> void:
	current_turn = 0
	textbox.visible = false
	Fight.visible = false
	enemy.visible = false
	box.visible = true
	nameplate.visible = false
	print("ready!")
	print("Enemy HP: ", enemy_Hp)
	print("Enemy Label: ", enemy_text)

func start_attack():
	var center = $Center
	attack = attack1.instantiate()
	attack.position = center.position
	add_child(attack)
	finished = attack.finished
	
	
func _process(delta: float) -> void:
	if attack != null:
		finished = attack.finished
	enemy_text.text = str(enemy_Hp)
	if attack == null:
		print("attack is null")
	if finished and current_turn == 1:
		finished = false
	match current_turn:
		5:
			pass
		4:
			pass
		3:
			pass
		2:
			pass
		1:
			current_turn = 4
			await get_tree().create_timer(delay).timeout
			menu()
		0:
			phase2()
		
	if finished and current_turn == 3:
		current_turn = 1
	if enemy_Hp < 0:
		current_turn = 5
		end_battle()
func menu():
	current_turn = 2
	box.visible = false
	textbox.visible = true
	enemy.visible = true
	fight.visible = true
	nameplate.visible = false
	text.visible = true
	text.visible_characters = 0
	await get_tree().create_timer(0.05).timeout
	text.text = message
	for i in range(message.length()):
		text.visible_characters +=1
		await get_tree().create_timer(txt_spd).timeout
func phase2():
	current_turn = 3
	textbox.visible = false
	Fight.visible = false
	enemy.visible = false
	box.visible = true
	start_attack()
	

func _on_fight_pressed() -> void:#fight button pressed
	text.visible = false
	nameplate.visible = true
	
func _on_dummyname_pressed() -> void: #this is when the player chooses to attack
	print("clicked")
	if player_Atk > enemy_Def:
		enemy_Hp -= dmg
	await get_tree().create_timer(delay).timeout
	current_turn = 0


func end_battle():
	enemy.visible = false
	enemy_Hp = 0
	text.text = "you win"
	await get_tree().create_timer(delay).timeout
	get_tree().change_scene_to_file("res://levels/level_3.tscn")
