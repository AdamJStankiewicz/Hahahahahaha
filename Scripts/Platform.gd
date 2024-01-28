extends StaticBody2D

var rotSpeed := 250
@onready var timer = $"../Timer"
@onready var egg = $"../Egg"
@onready var main = $"../"

const EGG = preload("res://Objects/egg.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("left"):
		rotation_degrees -= rotSpeed * delta
	if Input.is_action_pressed("right"):
		rotation_degrees += rotSpeed * delta
	
func game_over():
	get_tree().reload_current_scene()
	egg.queue_free()
	var instance = EGG.instantiate()
	instance.name = "egg"
	main.add_child(instance)
	egg = instance
	rotation_degrees = 0
	timer.stop()
	timer.wait_time = 10
	main.amntLeft = 5
	timer.start()


func _on_death_body_entered(body):
	game_over()


func _on_timer_timeout():
	game_over()
