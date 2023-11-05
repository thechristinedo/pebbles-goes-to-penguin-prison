extends Resource

@export var recoil: float = 3
@export var firerate: float = 0.18

var bullet_scene: PackedScene = load("res://Guns/Bullets/player_bullet.tscn")

func shoot() -> Array[Bullet]:
	var bullets: Array[Bullet]
	var bullet = bullet_scene.instantiate()
	
	bullets.append(bullet)
	return bullets

func type():
	return "machinegun"
