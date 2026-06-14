extends Node

@onready var r: RhythmNotifier = $"../RhythmNotifier"
@onready var currentNotes: Array[ManiaManager.ActiveNote] = $"../ManiaManager".active_notes

func _unhandled_key_input(event) -> void:
	if !r.running:
		return
	
	if  !event.is_pressed() or event.is_echo():
		return 
		
	if currentNotes.size() == 0:
		return
		
	var target_note: ManiaManager.ActiveNote = currentNotes[0]
		
	if event.is_action_pressed("mania_note_1"):
		if target_note.position != ManiaManager.BaseNote.One:
			return
	elif event.is_action_pressed("mania_note_2"):
		if target_note.position != ManiaManager.BaseNote.Two:
			return
	elif event.is_action_pressed("mania_note_3"):
		if target_note.position != ManiaManager.BaseNote.Three:
			return
	elif event.is_action_pressed("mania_note_4"):
		if target_note.position != ManiaManager.BaseNote.Four:
			return
	else:
		return
	
	var target_beat: int = r.current_beat
	var inp_error = r.current_position - (r.beat_length * int(r.current_beat))
	
	if r.beat_length - inp_error < r.beat_length/2:
		target_beat += 1
			
	
	if currentNotes[0].beat == target_beat:
		currentNotes[0].sprite.queue_free()
		print("TARGET SPRITE & NOTE ASSIGNED ", currentNotes.pop_front())
	
	if target_beat == int(r.current_beat):
		#late for the current beat
		print("LATE : BEAT TARGET, ERROR: ", [int(r.current_beat), inp_error])
	else:
		#early for the next beat
		print("EARLY: BEAT TARGET, ERROR: ", [int(r.current_beat)+1, -(r.beat_length - inp_error)])
	
	target_beat = -1
	
