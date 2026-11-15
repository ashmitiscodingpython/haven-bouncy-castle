extends Area2D

var pos = Vector2()
var time = 0
var initial_distance: float

func _ready() -> void:
	pos = position

func _process(delta: float) -> void:
	time += delta
	if not get_parent().name == "CanvasLayer":
		position = pos + Vector2(0, sin(time * 2) * 5)
	else:
		position += (Vector2(91, 158) - position) / 10
		var distance = position.distance_to(Vector2(91, 158))
		modulate = Color(1, 1, 1, (distance + 10) / initial_distance)
		if distance < 50:
			%GameManager.coins += 1
			queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and get_parent().name != "CanvasLayer":
		var screen_pos = get_global_transform_with_canvas().origin
		call_deferred("reparent", $"../CanvasLayer", true)
		position = screen_pos
		initial_distance = position.distance_to(Vector2(91, 158))
