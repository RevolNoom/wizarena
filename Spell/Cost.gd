extends Node

# PA = Player's attribute

# If true, the price can be higher than PA value
# But the required constraints must still be kept
export var allow_overprice = false

export var base_value = 0	# Solid requirement
export var sustain_weave=0	# price per second to sustain weaving this spell
export var sustain_value=0	# price per second to sustain activation of a spell

export var max_percentage = 0.0		# percentage based on PA max_value
export var current_percentage = 0.0	# percentage based on PA value/max_value
export var missing_percentage = 0.0	# percentage based on PA 1 - value/max_value

# PA must not be lower than this
export var min_required_value = 0

# PA must not be lower than this
#export var max_required_value = 0

# PA current percentage must not be lower than this
export var min_required_percentage = 0 

# PA current percentage must not be higher than this
#export var max_required_percentage = 1
