extends Node

@onready var firerate_timer = $Firerate

@export var gun: Gun

var _firerate: float
@onready var _can_fire: bool = true


func _ready():
	firerate_timer.set_one_shot(true)
	firerate_timer.connect("timeout", _set_can_fire)
	print("Gun: ", gun)
	if gun:
		print("Inventory Item: ", gun.inventory_item)
		if gun.inventory_item:
			print("Shooter: ", gun.inventory_item.shooter)
			if gun.inventory_item.shooter:
				set_fire_rate(gun.inventory_item.shooter.firerate)

func set_fire_rate(firerate: float) -> void:
	_firerate = firerate
	

func shoot() -> bool:
	print("Trying to shoot. Can fire:", _can_fire, "Timer started with firerate:", _firerate)
	if _can_fire: 
		_can_fire = false
		firerate_timer.start(_firerate)
		return gun.shoot()
	return false

func _set_can_fire() -> void:
	print("Timer finished. Setting _can_fire to true.")
	_can_fire = true
