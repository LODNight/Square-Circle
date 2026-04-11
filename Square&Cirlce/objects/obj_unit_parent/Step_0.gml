var _nearest_enemy = instance_nearest(x, y, target_type);

// 1. Cập nhật mục tiêu gần nhất liên tục	
target = instance_nearest(x, y, target_type);

depth = -y;

if (instance_exists(target)) {
    var _dist = distance_to_object(target);
    
    // 2. Kiểm tra khoảng cách tấn công
    if (_dist <= atk_range) { 
        state = "ATTACK";
    } else {
        state = "MOVE";
        
        // 3. LOGIC DI CHUYỂN TỚI MỤC TIÊU
        // Tính góc từ mình tới địch
        var _dir = point_direction(x, y, target.x, target.y);
        
        // Di chuyển cả X và Y để áp sát
        x += lengthdir_x(move_speed, _dir);
        y += lengthdir_y(move_speed, _dir);
        
        // Giới hạn lính không đi quá vùng chiến trường (Y từ 500 - 760)
        y = clamp(y, 500, 760);
        
        // Quay mặt về phía mục tiêu
        if (target.x > x) image_xscale = 1; else image_xscale = -1;
    }
} else {
    // Nếu không thấy bất kỳ ai, cứ đi thẳng
    state = "MOVE";
    x += move_speed * side;
}


// 3. Thực hiện hành động
switch (state) {
    case "MOVE":
       // 1. Lấy hướng di chuyển tới mục tiêu (địch/tháp) như cũ
		var _dir = point_direction(x, y, target.x, target.y);
	    var _move_x = lengthdir_x(move_speed, _dir);
	    var _move_y = lengthdir_y(move_speed, _dir);

	    // 2. LOGIC GIÃN CÁCH (Separation)
	    var _sep_x = 0;
	    var _sep_y = 0;
	    var _sep_radius = 40;   // Khoảng cách lính muốn giữ với nhau (pixel)
	    var _sep_strength = 0.5; // Độ mạnh của lực đẩy (đừng để quá cao sẽ gây rung lính)

	    // Duyệt qua tất cả lính cùng phe (obj_unit_parent)
	    with (obj_unit_parent) {
			// Chỉ đẩy nếu là đồng đội (cùng side) và không phải chính mình
	        if (id != other.id && side == other.side) {
	            var _dist = point_distance(x, y, other.x, other.y);
            
	            if (_dist < _sep_radius && _dist > 0) {
	                // Tính hướng đẩy ra xa khỏi đồng đội đó
	                var _pushed_dir = point_direction(x, y, other.x, other.y);
	                _sep_x -= lengthdir_x(_sep_strength, _pushed_dir);
	                _sep_y -= lengthdir_y(_sep_strength, _pushed_dir);
	            }
	        }
	    }

	    // 3. CỘNG TỔNG CÁC LỰC: Hướng đi + Lực đẩy giãn cách
	    x += _move_x + _sep_x;
	    y += _move_y + _sep_y;

	    // Giới hạn vùng chiến trường (Y từ 500 - 760)
	    y = clamp(y, 500, 760);

	    // Quay mặt
	    if (target.x > x) image_xscale = 1; else image_xscale = -1;	    
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
    // Làm cho lính mờ dần
    image_alpha -= 0.05; 
    
    move_speed = 0; 

    if (image_alpha <= 0) {
        instance_destroy();
    }
    
    exit;
}
