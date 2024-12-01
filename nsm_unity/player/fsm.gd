extends Node2D
	
#var State = load("res://State.gd")
@export var default_state : State
var current_state
var states : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	print(states)
	if default_state:
		default_state.start()
		$Label.text = default_state.name
		current_state = default_state
	if (get_parent().get_parent().night) :
		get_parent().get_parent().night.connect(on_child_night)
		print("signal trouvé !")


	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if current_state:
		current_state.update(_delta)
	#state.update(delta)
	#match state.code:
		#"idle":
			#print("Idle")
			#if (Input.is_action_just_pressed("press_right")):
				#pass
		#"moving":
			#print("moving")
	pass
	
func _physics_process(_delta: float) -> void:
	if current_state:
		current_state.physic_update(_delta)
	pass

func on_child_transition(state, new_state_name : String) -> void:
	if !(new_state_name.to_lower() in states):
		print("Can't find state ?!")
		return
		
	var new_state = states.get(new_state_name.to_lower())
	
	if !new_state:
		print("Can't load state ?!")
		return
	
	if state != current_state:
		print("Signal emitted by not currently selected state ?")
		return
	
	if current_state:
		current_state.exit()
	
	new_state.start()
	$Label.text = new_state.name
	current_state = new_state
	
func on_child_night():
	current_state.exit()
	current_state = states.get("looking")
	current_state.start()
	pass
