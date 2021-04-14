extends Node

var words = [
	"adarusa", 
	"adiwarna",
	"arunika",
	"asmaraloka",
	"baswara",
	"candramawa",
	"candala",
	"cerpelai",
	"derana",
	"dirgantara",
	"ejawantah",
	"elegi",
	"eunoia",
	"jatmika",
	"jenggala",
	"jumantara",
	"kanagara",
	"karsa",
	"kelindan",
	"kidung",
	"klandestin",
	"kulacino",
	"lazuardi",
	"lembayung",
	"lengkara",
	"litani",
	"lindap",
	"lokannata",
	"menjura",
	"mangata",
	"meraki",
	"nayanika",
	"nirmala",
	"niskala",
	"nirwana",
	"nuraga",
	"pancarona",
	"puspas",
	"ranum",
	"renjana",
	"risak",
	"sabitah",
	"sandykala",
	"saujana",
	"senandika",
	"suryakanta",
	"swastamita",
	"taksa",
	"taklif",
	"trengginas",
	"undagi",
	"ugahari",
	"wanodya",
	"wiyata",
]

#var special_characters = [
	#"!",
	#"?",
	#",",
	#".",
#]

#---mendapat letter---
func get_prompt() -> String: #string berfungsi sebagai pembuat barisan karakter
	var word_index = randi() % words.size() #kalimat random disesuaikan ukuran
	#var special_index = randi() % special_characters.size()
	
	var word = words[word_index] #deklarasi kalimat
	#var special_character = special_characters[special_index]
	
	#var actual_word = word.substr(0, 1).to_upper() + word.substr(1).to_lower()
	var actual_word = word.substr(0, 1).to_lower() + word.substr(1).to_lower() #komposisi
	
	#return actual_word + special_character
	return actual_word #kembali
