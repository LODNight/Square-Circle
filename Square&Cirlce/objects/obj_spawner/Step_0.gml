// Luôn cập nhật bộ đếm cho tất cả các loại lính
scr_spawn_update_timers();

// --- LOGIC SPAWN ---

// 1: lính Kiếm
if (keyboard_check_pressed(ord("1")) && scr_can_spawn(obj_a_h_sworld)) {
    var _inst = instance_create_layer(obj_tower_player.x, irandom_range(min_spawn, max_spawn), "Instances", obj_a_h_sworld);
    
    // Kích hoạt cooldown dựa trên spawn_time của chính con lính đó
    var _name = object_get_name(obj_a_h_sworld);
    global.spawn_timers[$ _name] = _inst.spawn_time * 60; 
}

// 3: Cung thủ
if (keyboard_check_pressed(ord("2")) && scr_can_spawn(obj_a_h_archer)) {
    var _inst = instance_create_layer(obj_tower_player.x, irandom_range(min_spawn, max_spawn), "Instances", obj_a_h_archer);
    
    var _name = object_get_name(obj_a_h_archer);
    global.spawn_timers[$ _name] = _inst.spawn_time * 60;
}

// 3: Spear
if (keyboard_check_pressed(ord("3")) && scr_can_spawn(obj_a_h_spear)) {
    var _inst = instance_create_layer(obj_tower_player.x, irandom_range(min_spawn, max_spawn), "Instances", obj_a_h_spear);
    
    var _name = object_get_name(obj_a_h_spear);
    global.spawn_timers[$ _name] = _inst.spawn_time * 60;
}

// 4: Shield
if (keyboard_check_pressed(ord("4")) && scr_can_spawn(obj_a_h_shield)) {
    var _inst = instance_create_layer(obj_tower_player.x, irandom_range(min_spawn, max_spawn), "Instances", obj_a_h_shield);
    
    var _name = object_get_name(obj_a_h_shield);
    global.spawn_timers[$ _name] = _inst.spawn_time * 60;
}


// ============= ENEMY ===========

// Nhấn phím 2 cho Enemy
if (keyboard_check_pressed(ord("Q")) && scr_can_spawn(obj_e_orc_sworld)) {
    var _inst = instance_create_layer(obj_tower_enemy.x, irandom_range(min_spawn, max_spawn), "Instances", obj_e_orc_sworld);
    
    var _name = object_get_name(obj_e_orc_sworld);
    global.spawn_timers[$ _name] = _inst.spawn_time * 60;
}

// Nhấn phím 2 cho Enemy
if (keyboard_check_pressed(ord("W")) && scr_can_spawn(obj_e_dark_sm)) {
    var _inst = instance_create_layer(obj_tower_enemy.x, irandom_range(min_spawn, max_spawn), "Instances", obj_e_dark_sm);
    
    var _name = object_get_name(obj_e_dark_sm);
    global.spawn_timers[$ _name] = _inst.spawn_time * 60;
}




// --- LOGIC CLICK MOUSE TRÊN UI ---
if (mouse_check_button_pressed(mb_left)) {
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    
    var _btn_w = 64; 
    var _btn_h = 64;
    var _btn_y = 768 - 20 - _btn_h;
    var _spacing = 20;
    var _units = [obj_a_h_sworld, obj_a_h_archer, obj_a_h_spear, obj_a_h_shield];
    
    for(var i = 0; i < 4; i++) {
        var _bx = 40 + i * (_btn_w + _spacing);
        
        // Kiểm tra xem chuột có click trúng nút này không
        if (_mx >= _bx && _mx <= _bx + _btn_w && _my >= _btn_y && _my <= _btn_y + _btn_h) {
            
            if (scr_can_spawn(_units[i])) {
                var _inst = instance_create_layer(obj_tower_player.x, irandom_range(min_spawn, max_spawn), "Instances", _units[i]);
                var _name = object_get_name(_units[i]);
                global.spawn_timers[$ _name] = _inst.spawn_time * 60; // Gắn cooldown
            }
        }
    }
}
// ---------------------------------
