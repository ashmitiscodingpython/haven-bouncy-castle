extends Node2D

var coins = 0
var hearts = 3

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	$"../CanvasLayer/Hearts".number = hearts
	$"../CanvasLayer/Hearts".render()
	$"../CanvasLayer/Coins".number = coins
	$"../CanvasLayer/Coins".render()
