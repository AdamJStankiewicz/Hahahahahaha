extends Node
@export var eggNodePaths: Array = [];
@export var distance: int;
@export var jugglableHeight: int;
@export var breakingHeight: int;
@export var JUGGLE_LOCKOUT_TIMER: float = .5;
var juggleLockout: float; # After you press the juggle button, you cannot juggle again for 
var eggs: Array = []; # Active juggling eggs
var holdEggs: Array = []; # For releasing eggs at the start one at a time
@export var releaseDelay: float = 1.5;
var releaseTimer: float = 0.5; 
var throwSound: AudioStreamPlayer;
var crackSound: AudioStreamPlayer;

var lowestEgg: Node = null; # Lowest active egg that can be juggled

var retryButton: Node;
var gameOverButton: Node;
var failed: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	retryButton = $"Retry Button";
	gameOverButton = $"Game Over Button";
	throwSound = $"ThrowSoundAudioStreamPlayer";
	crackSound = $"CrackSoundAudioStreamPlayer";
	juggleLockout = 0;
	for eggNodePath in eggNodePaths:
		var egg: Node;
		egg = get_node(eggNodePath);
		print(egg);
		holdEggs.append(egg);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if releaseTimer > 0:
		releaseTimer -= delta
		if releaseTimer < 0:
			print("Release!")
			if len(holdEggs) > 0:
				var egg = holdEggs.pop_front();
				eggs.append(egg);
				egg.drop();
				releaseTimer = releaseDelay;
	if juggleLockout > 0:
		juggleLockout -= delta; 
		if juggleLockout < 0:
			juggleLockout = 0;
			
	# Break eggs / fail the game if any eggs below height
	# Update the lowest active egg for juggling, move an icon to it
	var removeEggs: Array = [];
	if lowestEgg != null:
		lowestEgg.modulate = Color(1,1,1,1);
	lowestEgg = null;
	var lowestEggHeight: float = -9999;
	for i in len(eggs):
		var egg = eggs[i];
		if egg.position.y >= breakingHeight:
			egg.crack();
			crackSound.play(0);
			if Global.retries > 1:
				retryButton.show();
			else:
				print("Game Over show")
				gameOverButton.show();
			failed = true;
			
			removeEggs.append(i);
		elif egg.position.y >= jugglableHeight and egg.position.y > lowestEggHeight:
			lowestEggHeight = egg.position.y
			lowestEgg = egg;
	if lowestEgg != null:
		if juggleLockout == 0:
			lowestEgg.modulate = Color(.5, .5, 1, 1)
		else:
			lowestEgg.modulate = Color(1, .5, .5, 1);
	for n in removeEggs:
		eggs.remove_at(n);
	
func _input(event):
	if event.is_action_pressed("ui_accept") and !failed:
		if juggleLockout == 0:
			if lowestEgg != null:
				var xspeed = -150;
				if lowestEgg.position.x < 0:
					xspeed = 150;
				lowestEgg.set_linear_velocity( Vector2(xspeed, -600));
				throwSound.play(0);
		juggleLockout += JUGGLE_LOCKOUT_TIMER;

