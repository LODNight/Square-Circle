
if (shake_timer > 0) {
    // 1. Giảm thời gian rung
    shake_timer--;
    
    // 2. Tính toán vị trí X mới bằng cách cộng/trừ ngẫu nhiên
    x = original_x + random_range(-shake_amount, shake_amount);
    
    // 3. Khi rung xong, trả tháp về vị trí cũ
    if (shake_timer <= 0) {
        x = original_x;
    }
}
