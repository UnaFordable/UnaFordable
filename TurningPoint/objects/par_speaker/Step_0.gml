var _dr = detection_radius;
if(point_in_rectangle(playerobject.x, playerobject.y, x-_dr, y-_dr, x+_dr, y+_dr)){
	if(my_textbox != noone){ 
		if(!instance_exists(my_textbox)){ my_textbox = noone; exit; }
	}
	//if I haven't already created my textbox, make one:
	else if(keyboard_check_pressed(interact_key)){
		if(instance_exists(obj_textbox)){ exit; }	//exit if a textbox already exists
		event_user(0);								//if you need variables to update for text
			
		//Hand over variables
		create_dialogue(my_text, my_speaker, my_effects, my_text_speed, my_types, my_next_line, my_scripts, my_text_col, my_emotion, my_emote);
	}
} else {	//if player moves outside of detection radius
	if(my_textbox != noone){
		with(my_textbox) instance_destroy();
		my_textbox = noone;
	}
}
