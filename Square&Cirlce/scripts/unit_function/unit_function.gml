
/// @description: UNIT CONTROL STATES
function scr_unit_control_states(){
    depth = -y;

    // 1. Check Chết & Hồi màu (Dùng chung)
    if (hp <= 0) state = UNIT_STATE.DIE;
    if (image_blend != c_white) image_blend = merge_color(image_blend, c_white, 0.1);

    // 2. Xử lý trạng thái DIE thoát sớm
    if (state == UNIT_STATE.DIE) {
        scr_unit_state_die();
        exit;
    }

   // 3. Quản lý Mục tiêu (Cập nhật liên tục khi đang đi)
    if (state == UNIT_STATE.MOVE) {
        target = instance_nearest(x, y, target_type);
    } else if (!instance_exists(target)) {
        // Nếu đang ATTACK mà mục tiêu bất ngờ chết/biến mất
        target = instance_nearest(x, y, target_type);
        state = UNIT_STATE.MOVE;
    }

    // 4. Quyết định hành động dựa trên khoảng cách
    if (instance_exists(target)) {
        var _dist = distance_to_object(target);
        
        if (_dist <= atk_range) {
            if (state != UNIT_STATE.ATTACK) {
                state = UNIT_STATE.ATTACK;
                
                // Đòn đánh đầu tiên: Đánh ngay (chỉ cần bằng thời gian animation)
                var _frames = sprite_get_number(spr_attack);
                var _spr_fps = sprite_get_speed(spr_attack);
                var _spd_type = sprite_get_speed_type(spr_attack);
                
                var _v_dur = 30;
                if (_spr_fps > 0) {
                    if (_spd_type == spritespeed_framespersecond) {
                        _v_dur = (_frames / _spr_fps) * game_get_speed(gamespeed_fps);
                    } else {
                        _v_dur = _frames / _spr_fps;
                    }
                }
                if (_v_dur > atk_speed) _v_dur = atk_speed;
                
                attack_timer = _v_dur; 
            }
        } else if (state == UNIT_STATE.ATTACK) {
            // Mục tiêu chạy ra khỏi tầm đánh -> Đuổi theo
            state = UNIT_STATE.MOVE; 
        }
    }

    // 5. Execute States
    if (state == UNIT_STATE.MOVE) scr_unit_state_move();
    else if (state == UNIT_STATE.ATTACK) scr_unit_state_attack();

}

/// @description: UNIT MOVE
function scr_unit_state_move(){
    var _vx = 0, _vy = 0;

    if (instance_exists(target)) {
        var _dir = point_direction(x, y, target.x, target.y);
        _vx = lengthdir_x(move_speed, _dir);
        _vy = lengthdir_y(move_speed, _dir);
    } else {
        _vx = move_speed * side;
    }

    // Logic Giãn cách (Chỉ chạy khi thực sự di chuyển)
    var _sep_x = 0, _sep_y = 0;
    with (obj_unit_parent) {
        if (id != other.id && side == other.side) {
            var _dist = point_distance(x, y, other.x, other.y);
            if (_dist < 40 && _dist > 0) {
                var _pdir = point_direction(x, y, other.x, other.y);
                _sep_x -= lengthdir_x(0.5, _pdir);
                _sep_y -= lengthdir_y(0.5, _pdir);
            }
        }
    }
    
    // Giới hạn lực đẩy giãn cách để tránh các unit bị đẩy đi quá nhanh khi tụ tập đông
    var _sep_limit = max(1.5, move_speed);
    var _sep_len = point_distance(0, 0, _sep_x, _sep_y);
    if (_sep_len > _sep_limit) {
        _sep_x = (_sep_x / _sep_len) * _sep_limit;
        _sep_y = (_sep_y / _sep_len) * _sep_limit;
    }

    x += _vx + _sep_x;
    var _min_y = instance_exists(obj_spawner) ? obj_spawner.min_spawn : 500;
    var _max_y = instance_exists(obj_spawner) ? obj_spawner.max_spawn : 760;
    y = clamp(y + _vy + _sep_y, _min_y, _max_y);
    
    image_xscale = (_vx != 0) ? sign(_vx) : side;
    if (sprite_index != spr_idle) {
        sprite_index = spr_idle;
        image_speed = 1;
    }
}

/// @description: UNIT ATTACK
function scr_unit_state_attack(){
    if (!instance_exists(target)) { state = UNIT_STATE.MOVE; return; }
    image_xscale = (target.x > x) ? 1 : -1;
	
    if (attack_timer > 0) {
        attack_timer--;
        
        // Nội suy Animation dựa trên tốc độ thực tế của sprite (để chạy đúng fps)
        var _frames = sprite_get_number(spr_attack);
        var _spr_fps = sprite_get_speed(spr_attack);
        var _spd_type = sprite_get_speed_type(spr_attack);
        
        var _v_dur = 30; // Mặc định
        if (_spr_fps > 0) {
            if (_spd_type == spritespeed_framespersecond) {
                _v_dur = (_frames / _spr_fps) * game_get_speed(gamespeed_fps);
            } else {
                _v_dur = _frames / _spr_fps;
            }
        }
        
        // Đảm bảo không vượt quá atk_speed để không bị hụt animation
        if (_v_dur > atk_speed) _v_dur = atk_speed;
        
        if (attack_timer < _v_dur) {
            // Đã vào frame đánh -> chạy animation đánh
            if (sprite_index != spr_attack) {
                sprite_index = spr_attack;
                image_speed = 0;
            }
            image_index = ((_v_dur - attack_timer) / _v_dur) * (_frames - 1);
        } else {
            // Trong lúc chờ hồi chiêu -> chạy animation idle
            if (sprite_index != spr_idle) {
                sprite_index = spr_idle;
                image_speed = 1;
            }
        }
    } else {
        scr_deal_damage(id, target);
        attack_timer = atk_speed;
        
        // Spawn 4 obj_e_dark_snake nếu là obj_e_dark_sm
        if (object_index == obj_e_dark_sm) {
            for (var i = 0; i < 4; i++) {
                var _dist = random(32);
                var _dir = random(360);
                var _spawn_x = x + lengthdir_x(_dist, _dir);
                var _spawn_y = y + lengthdir_y(_dist, _dir);
                instance_create_depth(_spawn_x, _spawn_y, depth, obj_e_dark_snake);
            }
        }
        
        if (target.hp <= 0) target = noone; // Để vòng lặp sau tự tìm target mới
    }
}

function scr_unit_state_die(){
    image_alpha -= 0.05;
    move_speed = 0;
    if (image_alpha <= 0) {
        instance_destroy();
    }
}