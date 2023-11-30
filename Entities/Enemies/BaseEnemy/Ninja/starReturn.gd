extends Node2D

const speed = 200
const impact_smoke: PackedScene = preload("res://Guns/Bullets/Effects/impact_smoke.tscn")

var snowman # The snowman reference
var direction # The original direction of the snowball
var recall = false # The recall state of the snowball

func _ready():
	add_to_group("bossBullets")
	var player = RoomManager.pebbles
	if player.animation_tree.get("parameters/conditions/is_sliding"):
		# If yes, ignore the player layer
		# set_collision_mask_value(1, false)
		get_node("Area2D").set_collision_mask_value(1, false)

func _process(delta):
	check_distance() # Check the distance to the snowman
	update_direction() # Update the direction based on the recall state
	position += direction * speed * delta # Move the snowball using the direction vector
	$Sprite2D.rotation += 0.1 # Rotate the sprite

func _on_kill_timer_timeout():
	queue_free()

func _on_area_2d_body_entered(body):
	if body.name == "Bullet": pass
	print("Collided with: ", body)
	if body.has_method("take_damage") and body.has_method("handle_player_shoot"):
		var damage = 2
		body.take_damage(damage)
	if body != snowman: # Destroy the snowball only if the body is not the snowman
		destroy()

func destroy():
	var smoke = impact_smoke.instantiate()
	smoke.global_position = global_position
	get_node("/root/World/RoomManager/Room").add_child(smoke)
	queue_free()

func check_distance():
	# Check the distance between the snowball and the snowman
	if snowman == null: return
	var dist = position.distance_to(snowman.position)
	if dist > 125: # If the distance is greater than 300 pixels, set the recall state to true
		recall = true

func update_direction():
	# Update the direction of the snowball based on the recall state
	if recall: # If the recall state is true, the direction should be the vector from the snowball to the snowman
		direction = (snowman.position - position).normalized()
	else: # If the recall state is false, the direction should be the original direction
		direction = direction
