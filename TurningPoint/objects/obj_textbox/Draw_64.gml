//Draw textbox
draw_sprite_ext(dialogue_box, 0, pos_x,pos_y, scale,scale, 0, c_white, 1);

//Draw portrait
if(portrait[page] != -1){
	draw_sprite_ext(portrait[page], emotion[page], pos_x-portrait_width, pos_y, scale,scale, 0, c_white, 1);

	#region Idle Animated Portrait
if(type[page] == 1 or char_count >= str_len) {
	if(portrait_idle[page] != -1){
		var _posx = pos_x-portrait_width; var _posy = pos_y;
		if(portrait_idle_x[page] != -1){ _posx += portrait_idle_x[page] * scale; }
		if(portrait_idle_y[page] != -1){ _posy += portrait_idle_y[page] * scale; }
		
		portrait_idle_c += portrait_idle_s[page];
		if(portrait_idle_c >= portrait_idle_n[page]){ portrait_idle_c = 0; }
		draw_sprite_ext(portrait_idle[page], portrait_idle_c, _posx, _posy, scale,scale, 0, c_white, 1);	
	}
}
#endregion

	draw_sprite_ext(portrait_frame, 0, pos_x-portrait_width, pos_y, scale,scale, 0, c_white, 1);
}

#region Draw name and namebox
var _cname = name[page]

if(_cname != "None"){
	//Draw namebox
	draw_sprite_ext(name_box, 0, name_box_x,name_box_y, scale,scale, 0, c_white, 1);
	
	//Draw name text
	c = name_col;
	draw_set_halign(fa_center);
	draw_set_font(name_font);
	draw_text_color(name_box_text_x, name_box_text_y, _cname, c,c,c,c, 1);
	draw_set_halign(fa_left);
}
#endregion

//Set font
draw_set_font(font[page]);

//--------Draw the text differently if we are in 1) a dialogue choice or 2) normal dialogue
#region TYPE 1: DIALOGUE CHOICE
if(type[page] == 1){
	//Variables we need
	var _col = default__col, _tp = text[page], _tpl = array_length(_tp), _txtwidth = _boxwidth-(2*x_buffer);
	var _cc = 1, _yy = pos_y+y_buffer, _xx = pos_x+x_buffer, _ii = 0, _iy = 0;
	
	//Loop through our choices, draw them, highlight the one we are selecting
	repeat(_tpl){
		if(choice == _ii){ 
			if(chosen) { _col = select_col; }
			else	   { _col = choice_col; }
		} else { _col = c_white; }
		
		//Draw our choices
		var _ctext = "* "+_tp[_ii];
		draw_text_ext_color(_xx, _yy+((_ii+_iy)*stringheight), _ctext, stringheight, _txtwidth, _col, _col, _col, _col, 1); 
		
		if(string_width(_ctext) > _txtwidth) { _iy++; }
		_ii++; 
	}
} 
#endregion

#region TYPE 0: NORMAL DIALOGUE
else {
	//Detect pauses, play voice sound, increment our "typewriter"
	//Only need to do this if we haven't typed everything out AND we aren't already paused
	
	if(char_count < str_len and !pause){
		
		#region Increment character counter (charCount) every frame, used for "typewriter"
		var _tsc2 = text_speed_c*2;
		var _txtspd = text_speed[page];
		if(text_speed_c+1 < text_speed_al and char_count == _txtspd[_tsc2+2]) {
			text_speed_c++;
			_tsc2 = text_speed_c*2;
		}
		char_count += _txtspd[_tsc2+1];
		#endregion
		
		//Get Current Character
		var _ch = string_char_at(text_ne, floor(char_count));
		
		#region Check for Pause, Voice, Animated Sprite
		switch(_ch){
			case " ": break;
			case ",":
			case ".":
				pause = true;
				alarm[1] = 10;	//how many frames we wait if we detect a fullstop or comma
				break;
			
			case "?":
			case "!":
				pause = true;
				alarm[1] = 20;	//how many frames we wait if we detect a ! or ?
				break;
			default:
				
				//Play the voice sound every 2 frames (you can change this number if this is too often)
				var _audio_increment = 2;
				
				#region Animated Sprite
				if(portrait_talk[page] != -1) {
					if(!pause) {
						var _posx = pos_x-portrait_width; var _posy = pos_y;
						if(portrait_talk_x[page] != -1){ _posx += portrait_talk_x[page] * scale; }
						if(portrait_talk_y[page] != -1){ _posy += portrait_talk_y[page] * scale; }
		
						portrait_talk_c += portrait_talk_s[page];
		
						//To include the consideration of vowels
						//*/
						var _l = string_lower(_ch);
						if(_l == "a" or _l == "e" or _l == "i" or _l == "o" or _l == "u"){ 
							portrait_talk_c = open_mouth_frame; 
							if (char_count > audio_c) { 
								audio_play_sound(voice[page], 1, false); 
								audio_c = char_count + _audio_increment; 
							} 
						}
						/*/
						if (charCount > audio_c) { 
							audio_play_sound(voice[page], 1, false); 
							audio_c = charCount + _audio_increment; 
						} 
						//*/
						if(portrait_talk_c > portrait_talk_n[page]){ portrait_talk_c = 0; }
						draw_sprite_ext(portrait_talk[page], portrait_talk_c, _posx, _posy, scale,scale, 0, c_white, 1);	
					}
				} 
				#endregion
				else if (char_count >= audio_c) { audio_play_sound(voice[page], 1, false); audio_c = char_count + _audio_increment; }
		}
		#endregion
		
	}

	//---------------------------------Setup for Effects----------------------------//
	#region
	var _col = default_col, _cc = 1, _yy = pos_y+y_buffer, _xx = pos_x+x_buffer, _cx = 0, _cy = 0, _lineswidth;
	var _ty = 0, _by = 0, _bp_len = -1, _effect = 0, _next_space, _breakpoint = 0, _effects_c = 0, _text_col_c = 0;
	var _bp_array = breakpoints, _txtwidth = _boxwidth-(2*x_buffer), _char_max = _txtwidth div char_size; 
	
	//Check if there are breakpoints in this string, if there are save their lengths
	if(_bp_array != -1){ _bp_len = array_length(_bp_array); _next_space = breakpoints[_by]; _by++; }
	
	//For sin wave stuff
	t += 1;
	var _so = t;
	var _shift = sin(t*pi*2/60)*3;
	#endregion
	
	//---------------------------------Draw the Letters-----------------------------//
	#region
	
	repeat(char_count){
		//Get current letter
		letter = string_char_at(text_ne, _cc);
	
		var _ec2 = _effects_c*2;
		if(_effects_c < effects_al and effects_p[_ec2] == _cc){ 
			_effects_c++; 
			_effect = effects_p[_ec2+1];
		}
		
		var _tc2 = _text_col_c*2;
		if(_text_col_c < text__col_al and text_col_p[_tc2] == _cc){ 
			_text_col_c++;
			_col = text_col_p[_tc2+1];
		}
		
		//Get next space, deal with new lines
		if(_bp_len != -1 and _cc == _next_space){
			_cy += 1; _cx = 0;
			if(_by < _bp_len){
				_next_space = breakpoints[_by];
				_by++;
			}
		}
		
		switch(_effect){
			case 0:	//normal
				draw_text_color(_xx + (_cx*char_size), _yy+(_cy*stringheight), letter, _col, _col, _col, _col, 1);
				break;
			
			case 1:	//shakey
				draw_text_color(_xx + (_cx*char_size)+random_range(-1,1), _yy+(_cy*stringheight)+random_range(-1,1), letter, _col, _col, _col, _col, 1);
				break;
			
			case 2:	//wave
				_so = t;
				_shift = sin(_so*pi*freq/room_speed)*amplitude;
				draw_text_color(_xx + (_cx*char_size), _yy+(_cy*stringheight)+_shift, letter, _col, _col, _col, _col, 1);
				break; 
			
			case 3: //_colour _shift
				var _c1 = make_colour_hsv(t+_cc, 255, 255);
				var _c2 = make_colour_hsv(t+_cc+34, 255, 255);
				draw_text_color(_xx + (_cx*char_size), _yy+(_cy*stringheight), letter, _c1, _c1, _c2, _c2, 1);
				break;
		
			case 4: //wave AND _colour _shift
				_so = t + _cc;
				_shift = sin(_so*pi*freq/room_speed)*amplitude;
				var _c1 = make_colour_hsv(t+_cc, 255, 255);
				var _c2 = make_colour_hsv(t+_cc+45, 255, 255);
				draw_text_color(_xx + (_cx*char_size), _yy+(_cy*stringheight)+_shift, letter, _c1, _c1, _c2, _c2, 1);
				break; 
		
			case 5: //spin
				_so = t + _cc;
				_shift = sin(_so*pi*freq/room_speed);
				var _mv = char_size/2;
				draw_set_valign(fa_middle); draw_set_halign(fa_middle);
				draw_text_transformed_color(_xx + (_cx*char_size)+_mv, _yy+(_cy*stringheight)+(stringheight/2), letter, 1, 1, _shift*20, _col, _col, _col, _col, 1);
				draw_set_valign(fa_top); draw_set_halign(fa_left);
				break;
				
			case 6: //pulse
				_so = t + _cc;
				_shift = abs(sin(_so*pi*freq/room_speed));
				var _mv = char_size/2;
				draw_set_valign(fa_middle); draw_set_halign(fa_middle);
				draw_text_transformed_color(_xx + (_cx*char_size)+_mv, _yy+(_cy*stringheight)+(stringheight/2), letter, _shift, _shift, 0, _col, _col, _col, _col, 1);
				draw_set_valign(fa_top); draw_set_halign(fa_left);
				break;
				
			case 7:	//flicker
				_so = t + _cc;
				_shift = sin(_so*pi*freq/room_speed);
				draw_text_color(_xx + (_cx*char_size), _yy+(_cy*stringheight), letter, _col, _col, _col, _col, _shift+random_range(-1,1));
				break; 
		}
		
		//Increment variables for next letter
		_cc += 1;
		_cx += 1;
	}
	#endregion
	
	#region Draw "Finished" _effect
	if(char_count >= str_len){
		_shift = sin((t+_cc)*pi*freq/room_speed)*amplitude;
		finishede_count += finishede_spd;
		if(finishede_count >= finishede_num){ finishede_count = 0; }
		draw_sprite(finished_effect, finishede_count, finishede_x + _shift, finishede_y);
	}
	#endregion
}
#endregion