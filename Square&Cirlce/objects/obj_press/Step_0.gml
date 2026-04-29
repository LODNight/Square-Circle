/// @description Insert description here
// You can write your code in this editor

// Hiệu ứng lắc nhẹ lên xuống
y = ystart + dsin(current_time / 3) * 5;

// Chuyển sang rm_lv1 khi nhấn nút bất kì (bàn phím hoặc chuột)
if (keyboard_check_pressed(vk_anykey) || mouse_check_button_pressed(mb_any)) {
    room_goto(rm_lv1);
}
