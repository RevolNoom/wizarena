extends GuestEntry

func _ready():
	connect("to_play_queue", self, "_on_YouEntry_to_play_queue")
	connect("to_wait_queue", self, "_on_YouEntry_to_wait_queue")


func _on_YouEntry_to_play_queue(_entry):
	$Move.disabled = false
	
	
func _on_YouEntry_to_wait_queue(_entry):
	$Move.disabled = true
