// Tọa độ này ông căn chỉnh sao cho khớp với cái khung đen trong hình của ông nhé
var _gui_x = 40; 
var _gui_y = 25;
var _bar_w = 300; // Độ dài thanh máu (khớp với khung UI)
var _bar_h = 30;

var _hp_percent = (hp / max_hp) * 100;

// Vẽ thanh máu Player (Màu xanh)
draw_healthbar(_gui_x, _gui_y, _gui_x + _bar_w, _gui_y + _bar_h, _hp_percent, c_black, c_red, c_lime, 0, true, true);

// Thêm text cho chuyên nghiệp
draw_set_color(c_black);
draw_text(_gui_x + 5, _gui_y + 5, string(hp) + "/" + string(max_hp));	
