extends Control

export (int) var minutes = 0 #deklarasi menit awal menjadi nol 
export (int) var seconds = 0 #deklarasi detik awal menjadi nol 
var desec = 0 #milisecond

func _physics_process(delta):
	if seconds > 0 and desec <= 0: #jika lebih dari 0 detik
		seconds -= 1 
		desec = 1 #milisecond itu 1
	if minutes > 0 and seconds <= 0: #jika lebih dari 0 menit
		minutes -= 1
		seconds = 60 #sedetik itu 60
	
	if minutes >= 10: #jika menit lebih dari 10
		$menit.set_text(str(minutes)) #cetak
	else: #melainkan
		$menit.set_text("0"+str(minutes)) #tetap cetak
	if seconds >= 10: #jika detik lebih dari 10
		$detik.set_text(str(seconds)) #cetak
	else: #melainkan
		$detik.set_text("0"+str(seconds)) #cetak


func _on_Timer_timeout(): #sinyal
		desec -= 1 
