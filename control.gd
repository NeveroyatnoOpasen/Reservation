extends Control
@onready var label = $Label
@onready var button = $Button

var dialogues = [
	".",
	"ПОШЕЛ НАХУЙ ДОЛБАЕБ.",
	"Я ТЕБЯ СЪЕМ.",
	"КАКОЙ ТЕБЕ ПИЗДЕЦ!"
]

var current_dialogue_index = 0
func _ready():
 label.visible = false
 $Label.text = dialogues[current_dialogue_index]
 $Button.connect("pressed", Callable(self, "_on_Button_pressed"))
 


func _on_Button_pressed():
 current_dialogue_index += 1
 label.visible = true
 if current_dialogue_index < dialogues.size():
   $Label.text = dialogues[current_dialogue_index]
   
 else:
   $Label.text = "НУ ВСЕ ЧЕ СМОТРИШЬ"
   $Button.disabled = true
   queue_free()
