
// 1. Hàm khởi tạo (Gọi 1 lần duy nhất trong Create Event của obj_spawner hoặc obj_game_control)
function scr_spawn_init() {
    global.spawn_timers = {}; 
}

// 2. Hàm kiểm tra xem lính đã hồi xong chưa
function scr_can_spawn(_unit_obj) {
    var _name = object_get_name(_unit_obj);
    
    // Nếu chưa bao giờ spawn con này, khởi tạo timer = 0
    if (!variable_struct_exists(global.spawn_timers, _name)) {
        global.spawn_timers[$ _name] = 0;
    }
    
    return (global.spawn_timers[$ _name] <= 0);
}

// 3. Hàm cập nhật thời gian (Gọi trong Step Event của obj_spawner)
function scr_spawn_update_timers() {
    var _names = variable_struct_get_names(global.spawn_timers);
    for (var i = 0; i < array_length(_names); i++) {
        var _n = _names[i];
        if (global.spawn_timers[$ _n] > 0) {
            global.spawn_timers[$ _n]--;
        }
    }
}