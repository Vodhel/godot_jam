extends "res://State.gd"

@export var player : CharacterBody2D
@onready var player_raycast = player.get_node("RayCast2D")
@onready var player_pointLight = player.get_node("PointLight2D")
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
	pass
	
func exit() -> void:
	player_raycast.enabled = false
	player_pointLight.visible = false
	pass


func _on_fsm_looking_vote() -> void:
	print("In fsm looking vote")
	player_pointLight.visible = true
	player_raycast.enabled = true
	pass # Replace with function body.
