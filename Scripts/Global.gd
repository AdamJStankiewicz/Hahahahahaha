extends Node

var score = 3;
var retries = 3;
var victories = -1;

func _ready():
	pass

func random_game():
	victories += 1;
	
	var nextScene;
	if victories != 3:
		var minigameScenes = [
			"res://Minigames/JuggleGame/JuggleTest.tscn",
			"res://Minigames/egg-balance/eggroll.tscn",
			"res://Minigames/madlibs/madlib_minigame.tscn"
		];
		nextScene = minigameScenes[victories];
	else:
		nextScene =  "res://Victory.tscn"
		
	retries = 3;
	get_tree().change_scene_to_file(nextScene);

func game_over():
	get_tree().change_scene_to_file("res://Main.tscn");
	
func retry():
	retries -= 1
	if retries == 0:
		game_over();
	else:
		get_tree().reload_current_scene();
	
func begin():
	victories = -1;
	retries = 3;
	random_game();
