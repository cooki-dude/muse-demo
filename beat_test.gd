extends Node2D

@onready var r: RhythmNotifier = $RhythmNotifier  

func _ready() -> void:
	

	# Say the measure number at the start of each measure.  We add 1 to the beat count
	# provided, since musicians say "one" on the first measure but we count from 0.
	r.beats(1).connect(func(count):
		print("TIME %.2f, BEAT %2d  :    %d!" %
			[r.current_position, r.current_beat, count+1])
	)
	## Say the other downbeats in the measure
	#r.beat.connect(func(count):
		#if count % 4 != 0:
			#print("TIME %.2f, BEAT %2d  :       (%d)" % 
				#[r.current_position, count, (count % 4)+1])
	#)
	## Say the upbeats in the measure
	#r.beats(.5).connect(func(i):
		#if i % 2 != 0:
			#print("TIME %.2f, BEAT %4.1f:       (and)" %
				#[r.current_position, i/2.])
	#)
	
	r.audio_stream_player.play()
	r.running = true
