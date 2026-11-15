extends Camera2D

var shake = false
var shake_time = 0
var duration = 1
var intensity = 10

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	position += ($"../Character".position - position) / 5
	if shake:
		shake_time += _delta
		offset = Vector2(randf() * (duration - shake_time) * intensity, randf() * (duration - shake_time) * intensity)
		if shake_time >= duration:
			shake = false
