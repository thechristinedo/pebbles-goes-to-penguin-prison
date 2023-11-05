class_name Bullet
extends Area2D

@onready var lifetime_timer = $Lifetime

@export var speed: float = 30
@export var lifetime: float = 3

func _ready():
	lifetime_timer.connect("timeout", destroy, lifetime)
	lifetime_timer.start()

func _physics_process(delta):
	position += Vector2.RIGHT.rotated(rotation) * speed

func destroy():
	queue_free()

func _on_body_entered(body):
	if body.name == "player_bullet": pass
	destroy()
