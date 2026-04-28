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


// --- VẼ UI BUTTONS MUA LÍNH ---
var _btn_w = 64; 
var _btn_h = 64;
var _btn_y = 768 - 20 - _btn_h;
var _spacing = 20;

// Căn giữa UI Buttons
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _units = [obj_a_h_sworld, obj_a_h_archer, obj_a_h_spear, obj_a_h_shield];
var _sprites = [spr_a_h_sword_i, spr_a_h_archer_i, spr_a_h_spear_i, spr_a_h_shield_i];

for(var i = 0; i < 4; i++) {
    var _bx = 40 + i * (_btn_w + _spacing);
    
    // Vẽ nền nút (background)
    draw_set_color(c_dkgray);
    draw_rectangle(_bx, _btn_y, _bx + _btn_w, _btn_y + _btn_h, false);
    
    // Vẽ Sprite Lính
    draw_sprite_ext(_sprites[i], 0, _bx + _btn_w/2, _btn_y + _btn_h - 10, 0.7, 0.7, 0, c_white, 1);
    
    // Lớp phủ tối mờ nếu đang Cooldown
    if (!scr_can_spawn(_units[i])) {
        draw_set_color(c_black);
        draw_set_alpha(0.6);
        draw_rectangle(_bx, _btn_y, _bx + _btn_w, _btn_y + _btn_h, false);
        draw_set_alpha(1.0); // Reset alpha
    }

    // Hiệu ứng cooldown
    var _name = object_get_name(_units[i]);
    var _rem = global.spawn_timers[$ _name];
    if (_rem > 0) {
        var _pct = _rem / (_units[i].spawn_time * 60);
        draw_set_color(c_black);
        draw_set_alpha(0.6);
        draw_rectangle(_bx, _btn_y, _bx + _btn_w, _btn_y + _btn_h * _pct, false);
        draw_set_alpha(1.0);
    }
    
    // Viền trắng
    draw_set_color(c_white);
    draw_rectangle(_bx, _btn_y, _bx + _btn_w, _btn_y + _btn_h, true);
    
    // Chú thích Phím cứng cũ dưới góc
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text(_bx + _btn_w/2, _btn_y + _btn_h + 2, string(i + 1));
    draw_set_halign(fa_left); // Reset halign
}
// ------------------------------
