extends Node2D

@export var clock_max : int
var clock_current : int
@onready var timer = $Timer
@onready var clock_label = $Label

signal night
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clock_label.text = str(clock_max)
	clock_current = clock_max
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if clock_current > 0:
		clock_current -= 1
		clock_label.text = str(clock_current)
	else:
		timer.stop()
		$CanvasModulate.visible = true
		night.emit()
		#clock_current = 3
		#clock_label.text = str(clock_current)
		
	pass # Replace with function body.
