extends Sprite2D

func _ready() -> void:
	hframes = 9
	vframes = 11
	visible = false

func _process(_delta: float) -> void:
	pass

func confetti() -> void:
	for i in range(98):
		frame = i + 1
		await get_tree().create_timer(0.01).timeout
