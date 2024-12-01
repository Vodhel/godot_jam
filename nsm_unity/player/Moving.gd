extends "res://State.gd"

@export var body : CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func update(_delta: float) -> void:
	pass
	
func physic_update(_delta :float) -> void:
	if body.direction == Vector2.ZERO:
		Transitioned.emit(self, "Idle")
		return

	body.velocity.x = move_toward(body.velocity.x, body.direction.x * body.speed, body.acceleration)
	body.velocity.y = move_toward(body.velocity.y, body.direction.y * body.speed, body.acceleration)
	
	
	#body.velocity.x = body.direction.x * body.speed
	#body.velocity.y = body.direction.y * body.speed
	
func start() -> void:
	
	pass
	
func exit() -> void:
	pass
