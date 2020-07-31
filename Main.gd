extends Node2D

# PackedScene обеспечит упрощенный доступ к сериализованному объекту сцены
export (PackedScene) var coin   
export (int) var playtime

var sfx = AudioStreamPlayer2D.new()

var level = 1  # текущий уровень
var score  # текущие очки
var time_left    # время за которое длится игра
var window_size  # размер игрового окна
var playing = false  # игровая сессия не запущена

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()  # инициализируем генератор случайных чисел с некоторой случайной величиной
	window_size = get_viewport().get_visible_rect().size  # Определяем видимую область приложения
	$Player.window_size = window_size  # область ограничения для объекта "Игрок"
	$Player.hide()  # делаем игрока невидимым

func _process(delta):
	# Количество монеток на Уровне равно нулю?
	if playing and $CoinContainer.get_child_count() == 0:
		# тогда нужно увеличить уровень
		level += 1
		# немного "подсластим" игровой процесс
		time_left += 5
		# спавним монетки
		spawn_coins()
		$HUD.update_level(level)

func new_game():
	playing = true  # игровая сессия запущена
	level = 1 
	score = 0
	time_left = playtime
	$Player.start($PlayerStart.position)
	$Player.show()
	for coin in $CoinContainer.get_children():
		coin.queue_free()
	spawn_coins() # спавн монеток
	$HUD.update_level(level)
	$HUD.update_score(score)
	$HUD.update_time(time_left)
	$GameTimer.start() # запуск таймера обратного отсчета

func game_over():
	playing = false
	$GameTimer.stop()
	$HUD.show_game_over()
	$Player.die()
	self.add_child(sfx)
	sfx.stream = load("res://sfx/Explosion.wav")
	sfx.play()

func spawn_coins():
	print("Main.spawn_coins: level = "+String(level))
	for i in range(4 + level):
		var c = coin.instance()
		$CoinContainer.add_child(c)
		#c.position = Vector2(rand_range(0, window_size.x),
		#	rand_range(0, window_size.y))
		c.position = _G.rand_xy()


func _on_GameTimer_timeout():
	time_left -= 1  #отсчет счетчика
	$HUD.update_time(time_left)    #обновляем интерфейс счетчика
	if time_left <= 0:
		game_over()  # конец игры по окончанию счетчика


func _on_Player_pickup():
	score += 1
	self.add_child(sfx)
	sfx.stream = load("res://sfx/Player_pickup.wav")
	sfx.play()
	$HUD.update_score(score)


func _on_HUD_start_game():
	new_game()
