draw_self()
var _hp_percent = (hp / max_hp) * 100
draw_healthbar(x-20, y-60, x+20, y-55, _hp_percent, c_black, c_red, c_lime, 0, true, true)