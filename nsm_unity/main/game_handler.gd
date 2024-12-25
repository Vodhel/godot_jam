extends Node2D

@export var clock_max_day : int
@export var clock_max_night : int
var clock_current : int
@onready var timer = $Timer
@onready var clock_label = $Camera2D/HUD/Label
var mode = 0 # Decide if it's night countdown or day one -> Could be replaced by a state machine
				# 0 -> Day ; 1 -> Night
var votes = Array()
var playersID = {}
signal night
signal voting

var game_states = ["day", "night", "voting", "voted", "stuff"]
var current_game_state : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clock_label.text = str(clock_max_day)
	clock_current = clock_max_day
	current_game_state = game_states[0] # This is stupid
	timer.start()
	var nb_player = 1
	for children in $Camera2D/Game.get_children():
		if children is Player:
			children.found_player.connect(_on_found_player)
			votes.append(0)
			playersID[children] = (children.name.trim_prefix("Player").to_int()) 
			nb_player += 1
			print("Yaaay")
	print(playersID)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	match current_game_state:
		"day":
			pass
		"night":
			pass
		"voting":
			pass
		"voted":
			var max_vote = votes.max()
			var eliminated_ID = []
			for i in range(len(votes)):
				if votes[i] == max_vote:
					eliminated_ID.append(i)
			if eliminated_ID.size() > 1 or eliminated_ID.is_empty():
				print("No one voted out or ex aequo (to see if it does somethings else)")
				pass
			else:
				print("Player voted out :", playersID.find_key(eliminated_ID[0]))
				#Play animation/do stuff with an await
				playersID.find_key(eliminated_ID[0]).queue_free()
				pass
		 
			current_game_state = game_states[4]
		"stuff":
			pass
		_:
			print("Unkown / Undefined game state, quiting")
			get_tree().quit()
	pass


func _on_timer_timeout() -> void:
	if clock_current > 0:
		clock_current -= 1
		clock_label.text = str(clock_current)
	elif current_game_state == "day":
		$Camera2D/Game/CanvasModulate.visible = true
		night.emit()
		clock_current = clock_max_night
		clock_label.text = str(clock_current)
		current_game_state = game_states[1]
		print("cd 0 and day")
	elif current_game_state == "night":
		print("cd 0 and night")
		voting.emit()
		clock_current = 1
		$Camera2D/HUD/Label.visible = false
		current_game_state = game_states[2]
	elif current_game_state == "voting":
		current_game_state = game_states[3]
	pass # Replace with function body.

func _on_found_player(player : Player) -> void:
	print(player.name)
	votes[playersID[player]] += 1
	#print("Signal !")
	pass
