
/// @description: UNIT CONTROL STATES
function scr_unit_control_states(){
    depth = -y;

    if (hp <= 0) {
        state = "DIE";
    }
    
    if (state == "DIE") {
        scr_unit_state_die();
        exit; 
    }

    // HỒI MÀU: Đưa ra ngoài cùng để trạng thái nào cũng hồi màu được
    if (image_blend != c_white) {
        image_blend = merge_color(image_blend, c_white, 0.1); // 0.1 cho nó mượt hơn 0.5
    }

    target = instance_nearest(x, y, target_type);

    if (instance_exists(target)) {
        var _dist = distance_to_object(target);
        
        if (_dist <= atk_range) {
		    if (state != "ATTACK") {
		        state = "ATTACK";
		        // Khi vừa chạm địch, bắt đầu đếm ngược từ số frame của sprite + thêm một chút chờ
		        // Điều này giúp lính vung kiếm gần như ngay lập tức nhưng vẫn có nhịp nghỉ
		        var _f_count = sprite_get_number(spr_attack);
		        attack_timer = _f_count + 10; // Đợi 10 frame rồi chém luôn 6 frame
		    }
		} else {
            // SỬA LỖI: Nếu mục tiêu chạy xa quá tầm đánh, phải đuổi theo
            state = "MOVE";
        }
    } else {
        state = "MOVE"; 
    }

    switch (state) {
        case "MOVE":   scr_unit_state_move();   break;
        case "ATTACK": scr_unit_state_attack(); break;
    }
}

/// @description: UNIT MOVE
function scr_unit_state_move(){
    var _final_dir_x = 0;
    var _final_dir_y = 0;

    if (instance_exists(target)) {
        // Hướng tới mục tiêu
        var _dir = point_direction(x, y, target.x, target.y);
        _final_dir_x = lengthdir_x(move_speed, _dir);
        _final_dir_y = lengthdir_y(move_speed, _dir);
        
        // Quay mặt về phía mục tiêu
        image_xscale = (target.x > x) ? 1 : -1;
    } else {
        // Đi thẳng nếu không có mục tiêu
        _final_dir_x = move_speed * side;
        image_xscale = side;
    }

    // --- LOGIC GIÃN CÁCH (Separation) ---
    var _sep_x = 0;
    var _sep_y = 0;
    var _sep_radius = 40;
    var _sep_strength = 0.5;

    with (obj_unit_parent) {
        if (id != other.id && side == other.side) {
            var _d = point_distance(x, y, other.x, other.y);
            if (_d < _sep_radius && _d > 0) {
                var _p_dir = point_direction(x, y, other.x, other.y);
                _sep_x -= lengthdir_x(_sep_strength, _p_dir);
                _sep_y -= lengthdir_y(_sep_strength, _p_dir);
            }
        }
    }

    // Áp dụng di chuyển + Giãn cách + Giới hạn biên
    x += _final_dir_x + _sep_x;
    y += _final_dir_y + _sep_y;
    y = clamp(y, 500, 760);
    
    // Đổi animation sang Idle (vì ông chưa có sprite walk)
    if (sprite_index != spr_idle) {
	    sprite_index = spr_idle;
	} 
	
}


/// @description: UNIT ATTACK
function scr_unit_state_attack(){
    sprite_index = spr_attack;
    image_speed = 0; 

    if (instance_exists(target)) {
        image_xscale = (target.x > x) ? 1 : -1;

        var _total_frames = sprite_get_number(spr_attack);
        
        // === CHỈNH TỐC ĐỘ HÌNH ẢNH ===
        // 10 (nhanh)
        // 30 (chậm)
        var _visual_duration = 30; 
        // ===========================================

        if (attack_timer > 0) {
            attack_timer--;
            
            // Nếu timer bắt đầu đi vào "vùng hiển thị"
            if (attack_timer < _visual_duration) {
                // Công thức nội suy: Ép _visual_duration về khớp với _total_frames
                var _progress = (_visual_duration - attack_timer) / _visual_duration;
                image_index = _progress * (_total_frames - 1);
            } else {
                image_index = 0; // Vẫn đang chờ hồi chiêu, giữ frame đầu
            }
        } else {
            // Vả dame ngay khi timer về 0
            scr_deal_damage(id, target);
            
            attack_timer = atk_speed; 
            image_index = 0;
            
            if (target.hp <= 0) {
                target = noone;
                state = "MOVE";
                image_speed = 1;
            }
        }
    } else {
        state = "MOVE";
        image_speed = 1;
    }
}

function scr_unit_state_die(){
    image_alpha -= 0.05;
    move_speed = 0;
    if (image_alpha <= 0) {
        instance_destroy();
    }
}