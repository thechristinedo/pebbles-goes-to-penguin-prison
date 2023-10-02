extends HBoxContainer

@onready var ammo_amount_text: Label = $AmmoAmount

func update_ammo_amount(ammo_type: String, ammo_amount: int):
	if ammo_type == "shotgun":
		ammo_amount_text.text = "x " + str(ammo_amount)
