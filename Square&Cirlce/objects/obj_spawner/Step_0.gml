// Luôn cập nhật bộ đếm cho tất cả các loại lính
scr_spawn_update_timers();

// --- LOGIC SPAWN ---

// Nhấn phím 1 cho lính Kiếm
if (keyboard_check_pressed(ord("1")) && scr_can_spawn(obj_a_h_sworld)) {
    var _inst = instance_create_layer(obj_tower_player.x, irandom_range(640, 760), "Instances", obj_a_h_sworld);
    
    // Kích hoạt cooldown dựa trên spawn_time của chính con lính đó
    var _name = object_get_name(obj_a_h_sworld);
    global.spawn_timers[$ _name] = _inst.spawn_time * 60; 
}

// Nhấn phím 3 cho Cung thủ
if (keyboard_check_pressed(ord("3")) && scr_can_spawn(obj_a_h_archer)) {
    var _inst = instance_create_layer(obj_tower_player.x, irandom_range(640, 760), "Instances", obj_a_h_archer);
    
    var _name = object_get_name(obj_a_h_archer);
    global.spawn_timers[$ _name] = _inst.spawn_time * 60;
}

// Nhấn phím 2 cho Enemy
if (keyboard_check_pressed(ord("2")) && scr_can_spawn(obj_e_orc_sworld)) {
    var _inst = instance_create_layer(obj_tower_enemy.x, irandom_range(640, 760), "Instances", obj_e_orc_sworld);
    
    var _name = object_get_name(obj_e_orc_sworld);
    global.spawn_timers[$ _name] = _inst.spawn_time * 60;
}