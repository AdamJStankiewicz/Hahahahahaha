extends Area2D

@onready var col = $CollisionShape2D
@onready var main = $"../"

var rng = RandomNumberGenerator.new()
var canDie = false

func _ready():
	rng.randomize()

func collect():
	main.spawn_coin()
	queue_free()

func _on_body_entered(body):
	if canDie:
		collect()

func _on_timer_timeout():
	canDie = true
