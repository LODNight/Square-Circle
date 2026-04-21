
/// @desc Tính toán và áp dụng sát thương lên mục tiêu
/// @param _attacker ID của kẻ tấn công
/// @param _target   ID của kẻ bị tấn công
function scr_deal_damage(_attacker, _target){
    if (!instance_exists(_target)) return;

    // 1. Kiểm tra Né tránh (Dodge)
    var _roll = irandom(100);
    if (_roll < _target.dodge) {
        // Né được rồi! (Có thể hiện chữ "MISS" ở đây)
        return;
    }

    // 2. Tính sát thương cơ bản (Atk - Def)
    var _base_dmg = _attacker.atk_damage - _target.defense;
    
    // 3. Tính biến thiên (Random từ 90% đến 110% sát thương)
    var _variance = random_range(0.9, 1.1);
    var _final_dmg = _base_dmg * _variance;

    // 4. Đảm bảo sát thương tối thiểu là 1
    _final_dmg = max(1, round(_final_dmg));

    // 5. Trừ máu mục tiêu
    _target.hp -= _final_dmg;
	
	var text = instance_create_layer(_target.x, _target.y, "Instances", obj_damage_text)
	text.damage = _final_dmg
    
    // 6. Hiệu ứng Feedback (Nháy đỏ)
	if (_target.object_index == obj_tower_player || _target.object_index == obj_tower_enemy) {
        // NẾU LÀ NHÀ: Kích hoạt hiệu ứng rung
        _target.shake_amount = 4; // Rung 4 pixel (tùy chỉnh)
        _target.shake_timer = 15;  // Rung trong 15 frame (1/4 giây)
    } else {
        // NẾU LÀ LÍNH: Nháy đỏ như cũ
        _target.image_blend = c_red;
    }
}