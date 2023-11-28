extends CanvasModulate

const COLOR_NIGHT = Color("#091d3a")
const COLOR_DAY = Color("#FFFFFF")
const TIME_SCALE = 0.005
var time = 0

@onready var dia = $"../dia"
@onready var noite = $"../noite"

var lock : bool = false

signal night
signal day

func _process(delta:float):
	self.time += delta * TIME_SCALE
	if(abs(sin(time)) >= 0.5 ):
		if(lock):
			emit_signal("night")
			lock = false
			dia.stop()
			noite.play()
	elif(abs(sin(time)) < 0.5 ):
		if(lock == false):
			emit_signal("day")
			lock = true
			noite.stop()
			dia.play()
	self.color = COLOR_DAY.lerp(COLOR_NIGHT, abs(sin(time)))

