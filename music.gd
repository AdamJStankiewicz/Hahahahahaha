extends AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	stream = load('res://Audio/ggj - make me laugh.mp3');
	play(0);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
