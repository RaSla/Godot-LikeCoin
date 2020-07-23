extends Area2D

signal pickup
#signal die

export (int) var speed
var velocity = Vector2()
var window_size = Vector2(800, 600)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()

	position += velocity * delta
	position.x = clamp(position.x, 0, window_size.x)
	position.y = clamp(position.y, 0, window_size.y)

	if velocity.length() > 0:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_h = velocity.x < 0
	else:
		$AnimatedSprite.animation = "idle"

func start(pos):
	set_process(true)
	#глобальная позиция объекта в формате Vector2(x, y)
	position = pos
	$AnimatedSprite.animation = "idle"

func die():
	$AnimatedSprite.animation = "die"
	set_process(false)


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed


func _on_Player_area_entered(area):
	print_debug("Player touch " + area.get_name())
	emit_signal("pickup")
	area.pickup()
