extends KinematicBody2D

#---menambahkan warna menggunakan kode identik---
export (Color) var  red = Color ("#a65455") #kode untuk merah
export (Color) var  green = Color ("#639765") #kode untuk hijau
export (Color) var  blue = Color ("#4682b4") #kode untuk biru

#---kecepatan musuh bergerak---
export (float) var speed = 0.5 #floating point pergeseran

#---mendeklarasi setiap Node dan Class yang dibutuhkan---
onready var prompt = $RichTextLabel #berkas untuk text tabel dalam GE
onready var prompt_text = prompt.text #deklarasi

#---dipanggil saat Node sudah siap---
func _ready() -> void: #pemasukan pada void seperti permanent
	prompt_text = PromptList.get_prompt() #denah untuk kata
	prompt.parse_bbcode(set_center_tags(prompt_text)) #penguraian
	GlobalSignals.connect("difficulty_increase", self, "handle_difficulty_increased")

#---memastikan status mesin siap digunakan---
func _physics_process(_delta) -> void: ##pemasukan pada void seperti permanent
	global_position.x -= speed #gerak kearah minus

#---fungsi setting kesulitan---
func set_difficulty(difficulty: int):
	handle_difficulty_increase(difficulty) #mengatasi kesulitan bertambah

#---fungsi mengatasi kesulitan bertambah---
func handle_difficulty_increase(new_difficulty: int):
	var new_speed = speed + (0.250 * new_difficulty) #kecepatan bertambah 0.25 x kesulitan baru
	speed = clamp(new_speed, speed, 1)

#---mendapat letter---
func get_prompt() -> String: #string berfungsi sebagai pembuat barisan karakter
	return prompt_text #kembali ke text

#---fungsi mendesain letter---
func set_next_character(next_character_index: int): #integer
	var blue_text = get_bbcode_color_tag(blue) + prompt_text.substr(0, next_character_index) + get_bbcode_end_color_tag() #(0,X)
	var green_text = get_bbcode_color_tag(green) + prompt_text.substr(next_character_index, 1) + get_bbcode_end_color_tag() #(X,1)
	var red_text = ""
	if next_character_index != prompt_text.length(): #misal belum tersentuh
		red_text = get_bbcode_color_tag(red) + prompt_text.substr(next_character_index + 1, prompt_text.length() - next_character_index + 1) + get_bbcode_end_color_tag()
	#prompt.parse_bbcode("[center]" + blue_text + green_text + red_text + "[/center]")
	prompt.parse_bbcode(set_center_tags(blue_text + green_text + red_text)) #penguraian

#---fungsi letter untuk rata tengah---
func set_center_tags(string_to_center: String): #string berfungsi sebagai pembuat barisan karakter
	return "[center]" + string_to_center + "[/center]" #posisi tengah

#---fungsi letter untuk rata tengah---
func get_bbcode_color_tag(color: Color) -> String: #string berfungsi sebagai pembuat barisan karakter
	return "[color=#" + color.to_html(false) + "]" #mewarnai

#---fungsi mewarnai tag---
func get_bbcode_end_color_tag() -> String: #string berfungsi sebagai pembuat barisan karakter
	return "[/color]" #mewarnai

