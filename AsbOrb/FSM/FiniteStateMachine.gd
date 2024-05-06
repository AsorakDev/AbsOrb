extends Node
class_name FiniteStateMachine

var states : Dictionary = {}
var current_state : State
@export var initial_state : State

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_transition.connect(change_state)

	if initial_state:
		initial_state.stateEnter()
		current_state = initial_state

#Call the current states update function continuosly
func _process(delta):
	if current_state:
		current_state.stateUpdate(delta)

func change_state(source_state : State, new_state_name : String):
	if source_state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print("New state is empty")
		return
		
	if current_state:
		current_state.stateExit()
		
	new_state.stateEnter()
	
	current_state = new_state
