// --- Step Event của obj_unit_parent ---
var _nearest_enemy = instance_nearest(x, y, target_type);

if (instance_exists(_nearest_enemy)) {
    target = _nearest_enemy; // Cập nhật target là đứa gần nhất hiện tại
}

// 2. Nếu có mục tiêu, kiểm tra khoảng cách
if (instance_exists(target)) {
    var _dist = distance_to_object(target);
    
    // Nếu gần sát sạt (khoảng 5-10 pixel) thì dừng lại đánh
    if (_dist <= 5) { 
        state = "ATTACK";
    } else {
        state = "MOVE";
    }
} else {
    state = "MOVE"; // Nếu không thấy ai thì cứ đi tiếp
}

// 3. Thực hiện hành động
switch (state) {
    case "MOVE":
        sprite_index = spr_idle 
        x += move_speed * side  
        image_xscale = side     
        break
        
    case "ATTACK":
        sprite_index = spr_attack

        break
}

// ======== NGỦM =========
// 1. Kiểm tra nếu hết máu
if (hp <= 0 && state != "DIE") {
    state = "DIE";
    image_index = 0; 
    // sprite_index = spr_death; 
}

// 2. Nếu đang trong trạng thái DIE, thì không làm gì khác ngoài việc chờ biến mất
if (state == "DIE") {
    // Làm cho lính mờ dần (hiệu ứng đơn giản nhưng xịn)
    image_alpha -= 0.05; 
    
    move_speed = 0; 

    if (image_alpha <= 0) {
        instance_destroy();
    }
    
    exit;
}
