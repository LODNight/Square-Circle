if(player_cooldown > 0) player_cooldown--;
if(enemy_cooldown > 0) enemy_cooldown--;



if(keyboard_check(ord("1")) && player_cooldown < 1){
	y_ran = irandom_range(640, 760)
	instance_create_layer(obj_tower_player.x, y_ran, "Instances", obj_a_sworld_1);
	// 100, 500 là tọa độ bên trái màn hình	
	player_cooldown = spawn_cooldown
}

if(keyboard_check(ord("2")) && enemy_cooldown < 1){
	y_ran = irandom_range(640, 760)
	instance_create_layer(obj_tower_enemy.x, y_ran, "Instances", obj_e_sworld_1);
	// Spawn ở bên phải màn hình
	enemy_cooldown = spawn_cooldown
}

