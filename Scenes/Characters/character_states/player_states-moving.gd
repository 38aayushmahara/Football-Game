extends PlayerState
class_name PlayerStateMoving

func _physics_process_state(delta: float) -> void:
	if player.control_scheme == Player.Controlscheme.CPU:
		handle_cpu_movement()
	else:
		handle_human_movement()

	player.set_movement_animation()
	player.set_heading()

func handle_human_movement() -> void:
	var direction: Vector2 = KeyUtils.get_input_vector(player.control_scheme).normalized()
	player.velocity = direction * player.speed
	
	if player.velocity != Vector2.ZERO and KeyUtils.is_action_just_pressed(
		player.control_scheme,
		KeyUtils.Action.SHOOT
	):
		state_transition_requested.emit(Player.State.TACKLING)

func handle_cpu_movement() -> void:
	player.velocity = Vector2.ZERO
