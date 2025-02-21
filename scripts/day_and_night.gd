extends StaticBody2D

var state = "day"

var change_state = false

var length_of_day = 300
var length_of_night = 50


func _ready():
	if state == "day":
		$ColorRect.color.a = 0
	if state == "night":
		$ColorRect.color.a = 150

func _on_timer_timeout():
	if state == "day":
		state = "night"
	elif state == "night":
		state = "day"
		
	change_state = true

func _process(delta):
	if change_state == true:
		change_state = false
		if state == "day":
			change_to_day()
		elif state == "night":
			change_to_night()
		
			
func change_to_day():
	$AnimationPlayer.play("nighttoday")
	$Timer.wait_time = length_of_day
	$Timer.start()

func change_to_night():
	$AnimationPlayer.play("Rnight")
	$Timer.wait_time = length_of_night
	$Timer.start()
