extends Area2D

signal pickup
#signal die

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

#func start(pos):
#	set_process(true)
	#глобальная позиция объекта в формате Vector2(x, y)
	#position = pos
#	$AnimatedSprite.animation = "idle"

func die():
	print("Coin: die()")
	#$AnimatedSprite.animation = "die"
	set_process(false)

func pickup ():
	print("Coin: pickup()")
	queue_free ()
