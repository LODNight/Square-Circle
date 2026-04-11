// Chỉ số cơ bản (Sẽ bị ghi đè ở các lính con)
max_hp = 100;
hp = max_hp;
atk_damage = 10;
atk_range = 50;      // Khoảng cách để bắt đầu đánh
atk_speed = 60;      // Số frame giữa mỗi lần đánh (60 frame = 1s)
move_speed = 2;

// Trạng thái (State Machine)
state = "MOVE";      // MOVE, ATTACK, DIE
target = noone;
can_attack = true;


