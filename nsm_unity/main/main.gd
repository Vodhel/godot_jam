extends Node2D

var PATH_GAME_HANDLER = "res://main/game_Handler.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ResourceLoader.load_threaded_request(PATH_GAME_HANDLER)
	$MenuMain.start.connect(_on_start)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start() -> void:
	print("1")
	var game_handler_scene = ResourceLoader.load_threaded_get(PATH_GAME_HANDLER)
	print("2")
	var game_handler = game_handler_scene.instantiate()
	print("3")
	$MenuMain.queue_free()
	print("4")
	add_child(game_handler)
	print("5")
	pass
