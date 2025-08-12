class_name Player
extends CharacterBody2D

const DURATION_TACKLE := 200

enum Controlscheme { CPU, P1, P2 }
enum State { MOVING, TACKLING, RECOVERING}

@export var control_scheme: Controlscheme
@export var speed: float = 200.0
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var player_sprite: Sprite2D = %PlayerSprite

var current_state: PlayerState = null
var heading := Vector2.RIGHT
var state_factory := PlayerStateFactory.new()

const KeyUtils = preload("res://utils/key_utils.gd")

func _ready() -> void:
	switch_states(State.MOVING)

func _physics_process(delta: float) -> void:
	# Let the active state update velocity
	if current_state and current_state.has_method("_physics_process_state"):
		current_state._physics_process_state(delta)

	# Apply velocity to move player (Godot 4: no args)
	move_and_slide()

	# Then handle visuals
	flip_sprites()

func switch_states(state: State) -> void:
	if current_state != null:
		current_state.queue_free()
	current_state = state_factory.get_fresh_state(state)
	current_state.setup(self, animation_player)
	current_state.state_transition_requested.connect(switch_states)
	current_state.name = "PlayerStateMachine: " + str(state)
	call_deferred("add_child", current_state)

func set_movement_animation() -> void:
	if velocity.length() > 0:
		animation_player.play("run")
	else:
		animation_player.play("idle")

func set_heading() -> void:
	if velocity.x > 0:
		heading = Vector2.RIGHT
	elif velocity.x < 0:
		heading = Vector2.LEFT

func flip_sprites() -> void:
	if heading == Vector2.RIGHT:
		player_sprite.flip_h = false
	elif heading == Vector2.LEFT:
		player_sprite.flip_h = true
