extends Node2D

var amntLeft := 5

@onready var score = $Score
@onready var coins = $Coins
@onready var timer = $Timer
const COIN = preload("res://Objects/coin.tscn")
var RNG = RandomNumberGenerator.new()

func _physics_process(delta):
	score.text = str("Time Left: ",str(int(timer.time_left)));
	coins.text = str("Coins Left: ",str(int(amntLeft)));

func spawn_coin():
	RNG.randomize()
	var coin = COIN.instantiate()
	coin.position.x = RNG.randi_range(-250,250)
	add_child(coin)
	amntLeft -= 1
	if amntLeft <= 0:
		win()


func _on_timer_timeout():
	print("YOU LOSE!!! YOU GET NOTHING. NOTHING!!!")
	Global.retry()

func win():
	print("YOU WON!")
	Global.random_game()
