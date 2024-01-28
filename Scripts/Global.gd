extends Node

var score = 3;
var retries = 3;
var victories = 0;

func _ready():
	pass

func random_game():
	victories += 1;
	
	var nextScene;
	if victories == 3:
		var minigameScenes = ["res://Minigames/JuggleGame/JuggleTest.tscn"];
		nextScene = minigameScenes[0];
	else:
		nextScene =  "res://Victory.tscn"
		
	retries = 3;
	get_tree().change_scene_to_file(nextScene);

func game_over():
	get_tree().change_scene_to_file("res://Main.tscn");
	
func retry():
	retries -= 1
	get_tree().reload_current_scene()
	
func begin():
	victories = -1;
	retries = 3;
