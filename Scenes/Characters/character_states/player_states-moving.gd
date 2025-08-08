class_name PlayerStateMoving
extends Node
	
func physics_process(delta: float) -> void:
	owner.handle_human_movement()

	if owner.velocity.x != 0 and owner.KeyUtils.is_action_just_pressed(owner.control_scheme, owner.KeyUtils.Action.SHOOT):
		owner.state = owner.State.TACKING
		owner.time_start_tackle = Time.get_ticks_msec()
		owner.animation_player.play("tackle")
	else:
		owner.set_movement_animation()

	owner.flip_sprites()
	owner.set_heading()
