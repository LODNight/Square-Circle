if (state == "ATTACK" && instance_exists(target)) {
    // Chỉ trừ máu của thực thể cụ thể đang bị nhắm tới
    target.hp -= atk_damage;
    
    // Kiểm tra nếu mục tiêu (target) ngỏm
    if (target.hp <= 0) {
        // Kiểm tra xem ID này có phải là Tower không bằng hàm object_index
        if (target.object_index == obj_tower_enemy) {
            show_message("BẠN THẮNG RỒI!");
            game_restart();
        } 
        else if (target.object_index == obj_tower_player) {
            show_message("GAME OVER!");
            game_restart();
        }
        
        // Sau khi mục tiêu chết, reset target để đi tìm đứa khác
        target = noone;
    }
}