//// Creates variable (keyboards)
//key_left = keyboard_check(vk_left);
//key_right = keyboard_check(vk_right);
//key_jump = keyboard_check_pressed(vk_space);
//key_jump_held = keyboard_check(vk_space); // When keeping the space, jumps a bit more

//// Get horizontal move direction (-1 left, 1 right)
//var move = key_right - key_left;

//// Get horizontal speed
//hsp += move * accel;

//if (move == 0) // No key or both L and R keys pressed, slow down
//{
//	if (hsp < 0) // Going left
//	{
//		hsp = min(hsp + decel, 0) // negative increases to 0
//	}
//	else // Going right
//	{
//		hsp = max(hsp - decel, 0) // positive decreases towards 0
//	}
	
//}

//hsp = clamp(hsp, -max_hsp, max_hsp); // Limit horizontal speed
//x += hsp; // Update character's x-position

////Flipping
//if (hsp != 0)
//{
//image_xscale = sign(hsp);
//}

////// JUMPING
////if(jumpbuffer > 0){
	
////	jumpbuffer--;
	
////if(key_jump) and place_meeting(x, y + 1, Obj_platform){ // If space is pressed and the player touches a platform
	
////	vspeed -= 40; //Decrease vertical speed
////	jumpbuffer = 0;
////}
////}
////JUMPING
////if (jumpbuffer > 0) {
////    jumpbuffer--;

////    if (key_jump && place_meeting(x, y + 1, Obj_platform)) {
////        vspeed = min(vspeed - 30, -20); // Adjust both values for the desired jump height and descent speed
////        jumpbuffer = 0;
////    }
////}

//// JUMPING
//if (jumpbuffer > 0) {
//    jumpbuffer--;

//    if (key_jump) {
//        vspeed = -30; // Adjust the jump height
//        jumpbuffer = 0;
//    }
//}

//if (place_free(x, y + 1)) {
//    gravity = 1.0; // Experiment with different gravity values
//} else {
//    gravity = 0;
//    jumpbuffer = 10;
//}
////// Apply gravity
////vspeed += 1; // Adjust the gravity value as needed
////y += vspeed;

//// If the bear moves out of the room, restart the game
//if (y > room_height + 32) or (x > room_width) {
//	room_restart();
//}


//// If the bear moves up, other sprites move down
//if(vspeed < 0)
//{
	
//	with(Obj_move_parent)
//	{
//		y += 6;
//	}

//}
// Creates variable (keyboards)
key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_jump = keyboard_check_pressed(vk_space);
key_jump_held = keyboard_check(vk_space); // When keeping the space, jumps a bit more

// Get horizontal move direction (-1 left, 1 right)
var move = key_right - key_left;

// Get horizontal speed
hsp += move * accel;

if (move == 0) // No key or both L and R keys pressed, slow down
{
	if (hsp < 0) // Going left
	{
		hsp = min(hsp + decel, 0) // negative increases to 0
	}
	else // Going right
	{
		hsp = max(hsp - decel, 0) // positive decreases towards 0
	}
	
}

hsp = clamp(hsp, -max_hsp, max_hsp); // Limit horizontal speed
x += hsp; // Update character's x-position

// Flipping
if (hsp != 0)
{
    image_xscale = sign(hsp);
}

// JUMPING
if (jumpbuffer > 0) {
    jumpbuffer--;

    if (key_jump) {
        vspeed = -30; // Adjust the initial jump height
        gravity = 1.2; // Increase gravity during the jump for quicker descent
        jumpbuffer = 0;
    }
}

// Apply gravity
vspeed += gravity; // Adjust the gravity value as needed
y += vspeed;

// Check for ground collision (assuming vertical platforms)
if (place_free(x, y + 1)) {
    gravity = 1.0; // Reset gravity when in the air
} else {
    gravity = 0;
    jumpbuffer = 10;
}

// If the bear moves out of the room, restart the game
if (y > room_height + 50 || x > room_width) {
    room_restart();
}

// If the bear moves up, other sprites move down
if (vspeed < 0) {
    with (Obj_move_parent) {
        y += 20;
    }
}

//// Check if the cooldown is zero before spawning a bee
//if (global.bee_spawn_timer <= 0) {
//    // Spawn a bee
//    instance_create_layer(room_width, irandom_range(0, room_height), "Instances", Obj_bee);

//    // Set the cooldown to prevent immediate spawning
//    global.bee_spawn_timer = irandom_range(400, 800); // Adjust the cooldown duration as needed
//}

//// Reduce the cooldown on each step
//if (global.bee_spawn_timer > 0) {
//    global.bee_spawn_timer -= 1;
//}

//// In Obj_bear Step Event
//if (switch_back_timer > 0) {
//    switch_back_timer--; // Decrease the timer on each step

//// Check if the bear is colliding with a bee
//if (place_meeting(x, y, Obj_bee)) {
//        // Set the sprite_index to the desired sprite
//        sprite_index = Spr_player_defeated;

//        // Check if the collision was not processed in the previous step
//        if (!collision_processed) {
//            // Decrease honey pots only once per collision
//            global.pots_collected -= 1; // Decrease honey pots
//            collision_processed = true; // Set the flag to indicate collision processing
//        }
//    } else {
//        sprite_index = original_sprite; // Switch back to the original sprite
//        collision_processed = false; // Reset the collision processing flag
//    }
//} else {
//    sprite_index = original_sprite; // Switch back to the original sprite when the timer reaches 0
//    switch_back_timer = fps; // Reset the timer for the next collision
//}

// Check if the cooldown is zero before spawning a bee
if (global.bee_spawn_timer <= 0 && !global.icicles_enabled) {
    // Spawn a bee
    instance_create_layer(room_width, irandom_range(0, room_height), "Instances", Obj_bee);

    // Set the cooldown to prevent immediate spawning
    global.bee_spawn_timer = irandom_range(400, 800); // Adjust the cooldown duration as needed
}

// Check if the cooldown is zero before spawning an icicle
if (global.icicle_spawn_timer <= 0 && global.pots_collected >= 2)  {
    // Spawn an icicle
    instance_create_layer(irandom_range(0, room_width), -32, "Instances", Obj_icicle);

    // Set the cooldown to prevent immediate spawning
    global.icicle_spawn_timer = irandom_range(400, 800); // Adjust the cooldown duration as needed
}

// Reduce the cooldown on each step for bees
if (global.bee_spawn_timer > 0) {
    global.bee_spawn_timer -= 1;
}

// Reduce the cooldown on each step for icicles
if (global.icicle_spawn_timer > 0) {
    global.icicle_spawn_timer -= 1;
}

if (switch_back_timer > 0) {
    switch_back_timer--; // Decrease the timer on each step

    // Check if the bear is colliding with a bee
    if (place_meeting(x, y, Obj_bee)) {
        // Set the sprite_index to the desired sprite
        sprite_index = Spr_player_defeated;

        // Check if the collision was not processed in the previous step
        if (!collision_processed) {
            // Decrease honey pots only once per collision
            global.pots_collected -= 1; // Decrease honey pots
            collision_processed = true; // Set the flag to indicate collision processing
        }
    }
    // Check if the bear is colliding with an icicle
    else if (place_meeting(x, y, Obj_icicle)) {
        // Set the sprite_index to the desired sprite
        sprite_index = Spr_player_defeated;

        // Check if the collision was not processed in the previous step
        if (!collision_processed) {
			
            collision_processed = true; // Set the flag to indicate collision processing
        }
    } else {
        sprite_index = original_sprite; // Switch back to the original sprite
        collision_processed = false; // Reset the collision processing flag
    }
} else {
    sprite_index = original_sprite; // Switch back to the original sprite when the timer reaches 0
    switch_back_timer = fps; // Reset the timer for the next collision
}