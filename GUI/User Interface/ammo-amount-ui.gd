extends Label


func set_ammo_amount(ammo_amount: int):
	text = str(clampi(ammo_amount, 0, 30))
