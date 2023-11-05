class_name Bullet
extends RigidBody2D

@onready var lifetime_timer: Timer = $Lifetime

@export var speed: float = 800
@export var lifetime: float = 3

func _ready():
	lifetime_timer.connect("timeout", destroy, lifetime)
	lifetime_timer.start()

func _physics_process(delta):
	linear_velocity = Vector2.RIGHT.rotated(rotation) * speed

func _on_area_2d_body_entered(body):
	if body.name == "Bullet": pass
	destroy()

func destroy():
	queue_free()
