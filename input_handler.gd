extends Node

@onready var r: RhythmNotifier = $"../RhythmNotifier"

func _unhandled_key_input(event) -> void:
	if r.running and event.is_pressed() and !event.is_echo():
		var inp_error = r.current_position - (r.beat_length * int(r.current_beat))
		if r.beat_length - inp_error > r.beat_length/2:
			#late for the current beat
			print("LATE : BEAT TARGET: %d, ERROR: ", [int(r.current_beat) + 1, inp_error])
		else:
			#early for the next beat
			print("EARLY: BEAT TARGET: %d, ERROR: ", [int(r.current_beat), -(r.beat_length - inp_error)])
