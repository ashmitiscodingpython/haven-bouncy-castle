extends RigidBody2D

var movement = 0
var jump = false
var jumped = false
@export var squish = 0.0
var squish_velocity = 0
@export var spring = 10
@export var damp = 1
var squish_displacement = 0
var delta_y = 0
var ly = 0
var smooth_dy = 0
var grounded = false
var _rot = 0.0
var springed = false
var breathe = 0
var time = 0
var immortal = false
@onready var sprite = $Sprite2D

func _ready() -> void:
	ly = position.y
	
func _process(_delta: float) -> void:
	time += _delta
	movement = int(Input.is_key_pressed(KEY_D)) - int(Input.is_key_pressed(KEY_A))
	if jump:
		jumped = true
	if Input.is_key_pressed(KEY_W) and ((!jumped and grounded) or springed):
		jump = true
		if springed:
			springed = false
	elif !Input.is_key_pressed(KEY_W):
		jumped = false
	if jumped:
		jump = false
	if jump:
		apply_impulse(Vector2(0, -500))
	if immortal:
		modulate = Color(1, 1, 1, 0.6 + (sin(time) * 0.4))
	else:
		modulate = Color(1, 1, 1, 1)
	delta_y = position.y - ly
	ly = position.y
	smooth_dy += (delta_y - smooth_dy) / 10
	squish = smooth_dy / 2
	breathe = sin(time * 3) * 1
	sprite.scale = Vector2(1 - clamp(squish + breathe, -5, 5) / 10, 1 + clamp(squish + breathe, -5, 5) / 10)
	_rot += (movement * 18 - _rot) / 5
	sprite.rotation_degrees = _rot
	if (movement < 0 and sprite.scale.x > 0) or (movement >= 0 and sprite.scale.x < 0):
		sprite.scale.x = -sprite.scale.x

func squish_(_body):
	grounded = true
	ly = position.y + 100
	if springed:
		springed = false
	var tilemap = $"../TileMapLayer"
	var tile_pos = tilemap.local_to_map(global_position)
	var tile_data = tilemap.get_cell_tile_data(tile_pos)
	if tile_data:
		if tile_data.get_custom_data("ID") == "Ya this the bouncy pad":
			apply_impulse(Vector2(0, -500))
			springed = true
		if tile_data.get_custom_data("ID") == "me the spike" and !immortal:
			%GameManager.hearts -= 1
			immortal = true
			$"../Camera2D".shake = true
		else:
			immortal = false
		if tile_data.get_custom_data("ID") == "me the chest":
			if %GameManager.key_collected:
				tilemap.erase_cell(tile_pos)
				var coin = preload("res://scenes/coin.tscn")
				for i in range(randi() % 10):
					var co = coin.instantiate()
					co.add_to_group("coins")
					co.position = global_position + Vector2(randi_range(-20, 20), randi_range(-20, 20))
					get_tree().root.get_node("Node2D").add_child(co)
			

func ground_left(_body: Node) -> void:
	grounded = false

func _physics_process(_delta: float) -> void:
	apply_force(Vector2(movement * 500, 0))
