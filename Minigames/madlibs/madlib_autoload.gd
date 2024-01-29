extends Node

var available_madlibs = [
	"madlib_littlepigs",
	#"madlib1",
	#"madlib2",
]

@onready var remaining_madlibs = available_madlibs.duplicate()

# Called when the node enters the scene tree for the first time.
func _ready():
	remaining_madlibs.shuffle()

func has_next_madlib() -> bool:
	return not remaining_madlibs.is_empty()

func jump_next_madlib():
	# Do the Jump logic here ourselves so we can use Return in the Dialogic timeline we jumped to.
	Dialogic.current_state_info['jump_stack'].push_back({'timeline':Dialogic.current_timeline, 'index':Dialogic.current_event_idx, 'label': null})
	Dialogic.start_timeline(remaining_madlibs.pop_front())

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
