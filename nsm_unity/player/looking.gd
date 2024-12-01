extends "res://State.gd"

@export var player : CharacterBody2D

func update(_delta: float) -> void:
	if Input.is_action_just_pressed("A"):
		Transitioned.emit(self, "Idle")
	pass
func physic_update(_delta :float) -> void:
	
	# To keep fast switching Moving -> Idle -> Looking frmo making sliding glitch
	player.velocity.x = move_toward(player.velocity.x, 0, player.deceleration)
	player.velocity.y = move_toward(player.velocity.y, 0, player.deceleration)
	pass
	
func start() -> void:
	player.get_node("PointLight2D").visible = true
	pass
	
func exit() -> void:
	player.get_node("PointLight2D").visible = false
	pass
