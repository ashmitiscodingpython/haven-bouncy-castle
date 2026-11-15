extends Camera2D

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	position += ($"../Character".position - position) / 5
