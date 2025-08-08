class_name Player
extends CharacterBody2D

const DURATION_TACKLE := 200

enum Controlscheme { CPU, P1, P2 }
enum State { MOVING, TACKING }

@export var control_scheme: Controlscheme
@export var speed: float = 200.0
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var player_sprite: Sprite2D = %PlayerSprite

var heading := Vector2.RIGHT
var state := State.MOVING
var time_start_tackle := Time.get_ticks_msec()

const KeyUtils = preload("res://utils/key_utils.gd")

func _physics_process(_delta: float) -> void:
	if control_scheme == Controlscheme.CPU:
		pass
	else:
		if state == State.MOVING:
			handle_human_movement()
			if velocity.x != 0 and KeyUtils.is_action_just_pressed(control_scheme, KeyUtils.Action.SHOOT):
				state = State.TACKING
				time_start_tackle = Time.get_ticks_msec()
				set_movement_animation()
		elif state == State.TACKING:
			animation_player.play("tackle")
			if Time.get_ticks_msec() - time_start_tackle > DURATION_TACKLE:
				state = State.MOVING
# Test line for Git commit output

		flip_sprites()
		set_heading()
	move_and_slide()

func handle_human_movement() -> void:
	var direction := KeyUtils.get_input_vector(control_scheme).normalized()
	velocity = direction * speed

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
