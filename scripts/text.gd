extends Node2D

@export var number = 0
@export var width = 20

func _ready() -> void:
	render()

func _process(_delta: float) -> void:
	pass

func render() -> void:
	for child in get_children():
		child.queue_free()
	var text = str(number)
	for i in range(len(text)):
		var chara = text.substr(i, 1)
		var character = load("res://sprites/default/PNG/Default/ui_num%s.png" % chara)
		var sprite = Sprite2D.new()
		sprite.texture = character
		sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		sprite.position = Vector2(i * width * scale.x, 0)
		add_child(sprite)
