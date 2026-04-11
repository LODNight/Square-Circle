// 1. Vẫn phải vẽ cái tháp ra đã nhé
draw_self();

// 2. Thiết lập thông số thanh máu
var _bar_width = 120;  // Độ dài thanh máu
var _bar_height = 12;  // Độ dày thanh máu
var _x_offset = x - (_bar_width / 2); // Căn giữa thanh máu theo tháp
var _y_offset = y - 100;              // Đẩy thanh máu lên trên đầu tháp (tùy chỉnh theo chiều cao sprite của ông)

// 3. Tính toán tỷ lệ máu còn lại
var _hp_percent = (hp / max_hp);
_hp_percent = clamp(_hp_percent, 0, 1); // Đảm bảo không bị lỗi âm hoặc quá 100%

// 4. VẼ TẦNG 1: Viền đen (Border)
draw_set_color(c_black);
draw_rectangle(_x_offset - 2, _y_offset - 2, _x_offset + _bar_width + 2, _y_offset + _bar_height + 2, false);

// 5. VẼ TẦNG 2: Nền đỏ (Background - Máu đã mất)
draw_set_color(c_maroon);
draw_rectangle(_x_offset, _y_offset, _x_offset + _bar_width, _y_offset + _bar_height, false);

// 6. VẼ TẦNG 3: Thanh máu chính (Current HP)
// Phe mình màu xanh (c_lime), phe địch màu đỏ (c_red)
var _hp_color = (side == 1) ? c_lime : c_red; 
draw_set_color(_hp_color);
draw_rectangle(_x_offset, _y_offset, _x_offset + (_bar_width * _hp_percent), _y_offset + _bar_height, false);

// Reset lại màu vẽ để không ảnh hưởng các vật thể khác
draw_set_color(c_white);