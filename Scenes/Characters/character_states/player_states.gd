class_name player_states
extends Node

signal state_transition_requested(new_state: Player.State)

var player : Player = null

func setup(context_player:Player) -> void :
	player = context_player 
