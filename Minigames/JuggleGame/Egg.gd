extends RigidBody2D
@export var gravity: float = 0.4;
var cracked: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func crack():
	if cracked == false:
		print("Crack egg!");
		cracked = true;
		gravity_scale = 0;
		set_linear_velocity( Vector2(0,0));
		var crackedTexture = load("res://Art/Egg_cracked_new.png")
		$"Sprite2D".set_texture(crackedTexture);
		
func drop():
	gravity_scale = .4
	

