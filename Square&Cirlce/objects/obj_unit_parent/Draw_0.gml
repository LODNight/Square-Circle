draw_self()
var _hp_percent = (hp / max_hp) * 100
draw_healthbar(x-20, y-60, x+20, y-55, _hp_percent, c_black, c_red, c_lime, 0, true, true)

// Vẽ chỉ số atk_speed lên đầu lính để kiểm tra
//draw_set_color(c_yellow);
//draw_text(x, y - 80, "SPD: " + string(atk_speed));
//draw_text(x, y - 100, "Timer: " + string(attack_timer));