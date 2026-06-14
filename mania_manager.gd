class_name ManiaManager
extends Node

@export var note_delay: int = 2

@onready var BaseNote1: Sprite2D = $BaseNotes/Note1
@onready var BaseNote2: Sprite2D = $BaseNotes/Note2
@onready var BaseNote3: Sprite2D = $BaseNotes/Note3
@onready var BaseNote4: Sprite2D = $BaseNotes/Note4

enum BaseNote {
	One=1,
	Two=2,
	Three=3,
	Four=4
}

@onready var note_start_pos: int = BaseNote1.global_position.y
@onready var note_hit_line: int = $"../UI/HitLine".global_position.y
@onready var note_travel_dist: float = note_hit_line - note_start_pos
var note_end_pos:int = 680 #y value when note disappears

@onready var RhythmNotifier: RhythmNotifier = $"../RhythmNotifier"

var active_notes: Array[ActiveNote] = [] 
class ActiveNote:
	var sprite: Sprite2D
	var beat: int
	var position: BaseNote
	
	func _init(sprite_inp: Sprite2D, beat_inp: int, position_inp: BaseNote):
		sprite = sprite_inp
		beat = beat_inp
		position = position_inp


func spawn_new_note(position: BaseNote, note: int):
	var baseNote: Sprite2D
	var targetNote: int = note + note_delay
	
	match position:
		BaseNote.One:
			baseNote = BaseNote1
		BaseNote.Two:
			baseNote = BaseNote2
		BaseNote.Three:
			baseNote = BaseNote3
		BaseNote.Four:
			baseNote = BaseNote4
		_:
			printerr("SPAWN NEW NOTE POSITION ERROR")
	
	var newNote = baseNote.duplicate()
	add_child(newNote)
	active_notes.append(ActiveNote.new(newNote, targetNote, position))

func _ready() -> void:
	RhythmNotifier.beats(1).connect(func(count):
		spawn_new_note(randi_range(1, 4), count)
	)

func _process(delta: float) -> void:
	var note_percent = delta / RhythmNotifier.beat_length
	
	for target_note in active_notes:
		var note = target_note.sprite
		note.global_position.y += (note_percent * note_travel_dist) / note_delay
		
		if note.global_position.y > note_end_pos:
			note.queue_free()
			active_notes.pop_at(active_notes.find(target_note))
			
				
				
			
		
