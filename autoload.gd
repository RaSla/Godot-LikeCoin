extends Node

var window_w = 800
var window_h = 600
var window_border = 40

func rand_xy():
	var rrand = Vector2(rand_range(0+window_border, window_w-window_border),
		rand_range(0+window_border, window_h-window_border))
	return rrand  # возвращаем полученное значени
