extends Node

# Music tracks
const MUSIC_MENU = preload("res://Assets/MÚSICA 1 - Tribu Main Menu y Prólogo.wav")
const MUSIC_GAMEPLAY = preload("res://Assets/MÚSICA 2 - Tribu Gameplay Cozy.wav")
const MUSIC_LEVEL_COMPLETE = preload("res://Assets/MÚSICA 3 - Tribu Epílogo Festejo (BETA).wav")

var player: AudioStreamPlayer
var current_track: AudioStream = null
var should_loop: bool = true

func _ready():
	player = AudioStreamPlayer.new()
	add_child(player)
	player.finished.connect(_on_music_finished)

func play_menu_music():
	_play_track(MUSIC_MENU, true)

func play_gameplay_music():
	_play_track(MUSIC_GAMEPLAY, true)

func play_level_complete_music():
	_play_track(MUSIC_LEVEL_COMPLETE, true)

func _play_track(track: AudioStream, loop: bool = true):
	# Don't restart if already playing the same track
	if current_track == track and player.playing:
		return

	current_track = track
	should_loop = loop
	player.stream = track
	player.play()

func _on_music_finished():
	if should_loop and current_track:
		player.play()

func stop_music():
	player.stop()
	current_track = null
