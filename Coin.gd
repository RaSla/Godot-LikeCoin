extends Area2D

signal pickup

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func pickup ():
	print("Coin: pickup()")
	queue_free ()
