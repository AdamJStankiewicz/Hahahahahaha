extends RigidBody2D
@export var gravity: float = 0.4;
var cracked: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func crack():
	if cracked == false:
		print("Crack egg!");
		cracked = true;
		gravity_scale = 0;
		set_linear_velocity( Vector2(0,0));
		# linear_damp = 100;
	
		# TODO: change sprite
		
func drop():
	gravity_scale = .4
	

