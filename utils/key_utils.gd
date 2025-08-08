extends Node

enum Action { LEFT, RIGHT, UP, DOWN, SHOOT, PASS }

const Player = preload("res://Scenes/Characters/player.gd")  # ✅ Adjust this path if needed

const ACTION_MAP: Dictionary = {
	Player.Controlscheme.P1: {
		Action.LEFT: "p1_left",
		Action.RIGHT: "p1_right",
		Action.UP: "p1_up",
		Action.DOWN: "p1_down",
		Action.SHOOT: "p1_shoot",
		Action.PASS: "p1_pass",
	},
	Player.Controlscheme.P2: {
		Action.LEFT: "p2_left",
		Action.RIGHT: "p2_right",
		Action.UP: "p2_up",
		Action.DOWN: "p2_down",
		Action.SHOOT: "p2_shoot",
		Action.PASS: "p2_pass",
	},
}

static func get_input_vector(scheme: Player.Controlscheme) -> Vector2:
	var map: Dictionary = ACTION_MAP[scheme]
	var x = Input.get_action_strength(map[Action.RIGHT]) - Input.get_action_strength(map[Action.LEFT])
	var y = Input.get_action_strength(map[Action.DOWN]) - Input.get_action_strength(map[Action.UP])
	return Vector2(x, y)
	

static func is_action_pressed(scheme: Player.Controlscheme, action: Action) -> bool:
	return Input.is_action_pressed(ACTION_MAP[scheme][action])

static func is_action_just_pressed(scheme: Player.Controlscheme, action: Action) -> bool:
	return Input.is_action_just_pressed(ACTION_MAP[scheme][action])

static func is_action_just_released(scheme: Player.Controlscheme, action: Action) -> bool:
	return Input.is_action_just_released(ACTION_MAP[scheme][action])
