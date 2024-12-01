extends "res://State.gd"


# Called when the node enters the scene tree for the first time.
@export var body : CharacterBody2D

func update(_delta: float) -> void:
	if body.direction != Vector2.ZERO:
		Transitioned.emit(self, "Moving")
	if Input.is_action_just_pressed("A"):
		Transitioned.emit(self, "Looking")
	
func physic_update(_delta :float) -> void:
	body.velocity.x = move_toward(body.velocity.x, 0, body.deceleration)
	body.velocity.y = move_toward(body.velocity.y, 0, body.deceleration)
	
func start() -> void:
	pass
	
func exit() -> void:
	pass
