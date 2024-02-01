/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 3B6260FB
/// @DnDArgument : "code" "$(13_10)$(13_10)var bear_instance = instance_find(Obj_bear, 0);$(13_10)$(13_10)if (bear_instance && !chasing_bear) {$(13_10)    direction = point_direction(x, y, bear_instance.x, bear_instance.y);$(13_10)    // speed = 3; // Adjust the speed value as needed$(13_10)    x += lengthdir_x(speed, direction);$(13_10)    y += lengthdir_y(speed, direction);$(13_10)$(13_10)    chasing_bear = true; // Set the flag to indicate that this bee is now chasing the bear$(13_10)}$(13_10)$(13_10)// Reset the chasing flag when the bee reaches the bear or loses sight$(13_10)if (chasing_bear && bear_instance && point_distance(x, y, bear_instance.x, bear_instance.y) < 10) {$(13_10)    chasing_bear = false; // Reset the flag when the bee is close to the bear$(13_10)}$(13_10)$(13_10)"


var bear_instance = instance_find(Obj_bear, 0);

if (bear_instance && !chasing_bear) {
    direction = point_direction(x, y, bear_instance.x, bear_instance.y);
    // speed = 3; // Adjust the speed value as needed
    x += lengthdir_x(speed, direction);
    y += lengthdir_y(speed, direction);

    chasing_bear = true; // Set the flag to indicate that this bee is now chasing the bear
}

// Reset the chasing flag when the bee reaches the bear or loses sight
if (chasing_bear && bear_instance && point_distance(x, y, bear_instance.x, bear_instance.y) < 10) {
    chasing_bear = false; // Reset the flag when the bee is close to the bear
}