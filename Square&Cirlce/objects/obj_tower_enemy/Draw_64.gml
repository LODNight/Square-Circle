var _screen_w = display_get_gui_width();
var _bar_w = 300;
var _bar_h = 30;
var _gui_x = _screen_w - _bar_w - 40; // Cách lề phải 40px
var _gui_y = 25;

var _hp_percent = (hp / max_hp) * 100;

// Vẽ thanh máu Enemy (Màu đỏ)
// Tham số cuối cùng là 1 để thanh máu tụt từ phải sang trái (nhìn sẽ đối xứng hơn)
draw_healthbar(_gui_x, _gui_y, _gui_x + _bar_w, _gui_y + _bar_h, _hp_percent, c_black, c_red, c_maroon, 1, true, true);

draw_set_color(c_white);
draw_set_halign(fa_right); // Căn lề phải cho chữ
draw_text(_screen_w - 45, _gui_y + 5, string(hp) + "/" + string(max_hp));
draw_set_halign(fa_left); // Reset lại lề