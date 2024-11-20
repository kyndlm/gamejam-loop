extends CanvasLayer

@onready var health_bar = $PlayerInfo
@onready var health_label = $PlayerInfo/health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_health_label()
	
# Function to update the label text based on the TextureProgress value
func update_health_label():
	# Calculate health percentage based on the current value and max value
	var health_percentage = int((health_bar.value / health_bar.max_value) * 100)
	health_label.text = str(health_percentage)
