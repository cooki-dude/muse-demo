extends Node2D

@onready var r: RhythmNotifier = $RhythmNotifier  

@export var music_delay: int

func _ready() -> void:
	
	# Say the measure number at the start of each measure.  We add 1 to the beat count
	# provided, since musicians say "one" on the first measure but we count from 0.
	r.beats(1).connect(func(count):
		print("TIME %.2f, BEAT %2d  :    %d!" %
			[r.current_position, r.current_beat, count+1])
	)
	
	r.beats(0, false, music_delay).connect(func(_i):
		$AudioStreamPlayer.play()
	, CONNECT_ONE_SHOT)
	
	r.running = true
