extends Node2D

#---scene variabel dimuat disini---
var Enemy = preload("res://Scenes/Enemy.tscn") #file musuh
var battle_music = load("res://Autoloads/Soundtrack/welcome_horizons.wav") #file soundtrack

#---mendeklarasi setiap Node yang dibutuhkan---
onready var enemy_container = $EnemyContainer #berkas untuk musuh
onready var spawn_container = $SpawnContainer #berkas untuk spawn
onready var spawn_timer = $SpawnTmer #waktu muncul
onready var difficulty_timer = $DifficultyTimer #waktu susah

#---layer variabel dimuat disini---
onready var difficulty_value = $CanvasLayer/VBoxContainer/BawahRow/HBoxContainer/SusahValue #keterangan tingkatan
onready var score_value = $CanvasLayer/scoring/ScoreValue #keterangan score didappat
onready var highscore_value = $CanvasLayer/scoring/HighscoreValue #keterangan score tersimpan selama bermain
onready var game_over_screen = $CanvasLayer/GameOverScreen #kketerangan kekalahan

#---membangun lokasi cache disini---
const SAVE_FILE_PATH = "user://savedata.save" #nama file dokumentasi
var score = 0 #awal dari score
var highscore = 0 #awal dari highscore

#---reset ke awal mula permainan---
var active_enemy = null #null tidak memiliki nilai
var current_letter_index: int = -1 #memuat integer dari letter
var difficulty: int = 0 #memuat integer awal dari tingkatan kesusahan
var enemy_killed: int = 0 #memuat integer awal dari tingkatan kematian
#var not_started = true (?)

#---dipanggil saat Node sudah siap---
func _ready() -> void: #pemasukan pada void seperti permanent
	#yield(get_tree().create_timer(1800), "timeout") #countdown
	start_game() #pergi ke start_game
	load_highscore() #memuat load_highscore

#---fungsi untuk mencari musuh aktif terbaru---
func find_new_active_enemy(typed_character: String): #string berfungsi sebagai pembuat barisan karakter.
	for enemy in enemy_container.get_children(): #untuk kondisi musuh tertanam
		var prompt = enemy.get_prompt() #musuh mempunyai kata
		var next_character = prompt.substr(0, 1) #pergi ke huruf berikutnya
		
		if next_character == typed_character: #jika huruf pada musuh tertekan 
			print("kamu menemukan virus yang berawalan huruf %s" % next_character) #istilah
			active_enemy = enemy #pernyataan
			#print("new enemy detected")
			current_letter_index = 1 #pernyataan
			active_enemy.set_next_character(current_letter_index) #pernyataan
			return #kembali

#---fungsi masukan keyboard---
func _unhandled_input(event: InputEvent) -> void: #pemasukan pada void seperti permanent
	#if event is InputEventKey and not event.is_pressed():
	if event is InputEventKey and event.is_pressed(): #saat berlangsungnya pemasukan
		var typed_event = event as InputEventKey #deklarasi typed_event
		var key_typed = PoolByteArray([typed_event.unicode]).get_string_from_utf8() #sebuah Array khusus dirancang untuk byte ditahan.
		highscore_value.text = str(highscore) #cetak highscore
		
		if active_enemy == null: #jika musuh aktif tidak memiliki nilai
			find_new_active_enemy(key_typed) #menganalisa musuh
		else: #jika salah?
			var prompt = active_enemy.get_prompt() #kata pada musuh didapat
			var next_character = prompt.substr(current_letter_index, 1) #bisa masuk ke huruf selanjutnya
			
			if key_typed == next_character: #jika huruf benar maka bisa ke huruf selanjutnya
				print("kamu berhasil mengetik huruf %s" % key_typed) #istilah
				current_letter_index += 1 #maka letter bertambah 1
				active_enemy.set_next_character(current_letter_index) 
				if current_letter_index == prompt.length(): #jika benar selama panjangnya kata
					print("kamu telah membunuh virus") #istilah
					current_letter_index = -1 #maka letter berkurang 1 bertanda selesai
					active_enemy.queue_free() #kosong
					active_enemy = null #musuh aktif menjadi tidak memiliki nilai
					enemy_killed += 1 #maka keterangan pembunuhan bertambah
					score += 105 #maka keterangan score bertambah
					score_value.text = str(score) #cetak score
					#highscore_value.text = str(highscore) #cetak highscore
			else: #jika salah?
				print("kamu salah mengetik huruf %s seharusnya mengetik huruf %s" % [key_typed, next_character]) #istilah

#---fungsi untuk waktu memunculkan musuh, sesuai letak tanda koordinat yang telah dikoneksikan---
func _on_SpawnTmer_timeout(): #sinyal
	spawn_enemy() #kemana? fungsi spawn_enemy 

#---fungsi untuk memunculkan musuh---
func spawn_enemy():
	var enemy_instance = Enemy.instance() #Node induk terdefinisi dalam indeks
	var spawns = spawn_container.get_children() #mendapatkan anak dengan indeks
	var index = randi() % spawns.size() #random
	enemy_instance.global_position = spawns [index].global_position #musuh muncul pada posisi
	enemy_container.add_child(enemy_instance) #add_child menambahkan Node di posisi terakhir induk
	##enemy_instance.global_position = spawns [index].global_position #musuh muncul pada posisi
	enemy_instance.set_difficulty(difficulty) #singgung kesulitan

#---fungsi untuk waktu tingkat kesusahan---
func _on_DifficultyTimer_timeout(): #sinyal
	if difficulty >= 10: #jika lebih dari 10
		difficulty_timer.stop() #tidak ada penambahan
		difficulty = 10 #batas
		return #kembali
	difficulty += 1 #tingkat kesilitan bertambah satu
	GlobalSignals.emit_signal("difficulty_increase", difficulty) 
	print("tingkat kesusahan meningkat menjadi %d" % difficulty) #cetak
	var new_wait_time = spawn_timer.wait_time - 0.2 #deklarasi waktu tunggu baru
	spawn_timer.wait_time = clamp (new_wait_time, 1, spawn_timer.wait_time) #waktu tunggu bertingkat otomatis
	difficulty_value.text = str(difficulty) #cetak tingkat kesulitan
	#spawn_timer.wait_time -= 0.2 (?)

#---fungsi untuk dimensi batas---
func _on_Loser_body_entered(body: Node) -> void: #sinyal
	game_over() #pergi ke game_over

#---fungsi untuk memulai permainan---
func start_game():
	MusicController.play_music() #musik dinyalakan
	game_over_screen.hide() #layar disembunyikan
	difficulty = 0 #awal dari kesulitan
	enemy_killed = 0 #awal dari musuh terbunuh
	self.score = 0 #awal dari score berkembang sendirinya
	difficulty_value.text = str(0) 
	score_value.text = str(0) 
	randomize() #acak
	spawn_timer.start() #waktu spawn dimulai
	spawn_enemy() #keluar musuh

#---fungsi untuk score pemain---
func player_score():
	self.score += 105 #bertambah dengan sendirinya 105 point

#---fungsi untuk score baru---
func set_score(new_score):
	score = new_score #menyatakan score

#---fungsi untuk kalah permainan---
func game_over():
	game_over_screen.show() #layar ditampilkan
	spawn_timer.stop() #waktu spawn berhenti
	difficulty_timer.stop() #waktu kesulitan berhenti
	active_enemy = null #null tidak memiliki nilai
	current_letter_index = -1 #tidak bisa input kata
	for enemy in enemy_container.get_children(): #untuk musuh yang memiliki anak
		enemy.queue_free() #musuh bebas
	if score > highscore: #jika lebih dari
		highscore = score #highscore adalah score
		save_highscore() #menyimpan highscore

#---fungsi untuk menyimpan highscore---
func save_highscore():
	var save_data = File.new()
	save_data.open(SAVE_FILE_PATH, File.WRITE)
	save_data.store_var(highscore)
	save_data.close()

#---fungsi untuk menampilkan highscore---
func load_highscore():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE_PATH):
		save_data.open(SAVE_FILE_PATH, File.READ)
		highscore = save_data.get_var()
		save_data.close()

#SilentWolf.configure({
	#"api_key": "kMUNTACACw17tzOxjm6Ii8ViO3Y2sLqv3nzuAb2N",
	#"game_id": "Human Virus",
	#"game_version": "1.0.2",
	#"log_level": 1
#})
#SilentWolf.configure_scores({
	#"open_scene_on_close": "res://scenes/MainPage.tscn"
	#})

#---fungsi untuk tombol restart---
func _on_RestartButton_pressed(): #sinyal
	start_game() #pergi ke start_game

#---fungsi untuk tombol menu---
func _on_MenuButton_pressed(): #sinyal
	get_tree().change_scene("res://Scenes/MainMenu.tscn") #berpindah scene
	MusicController.stop_music() #musik berhenti
