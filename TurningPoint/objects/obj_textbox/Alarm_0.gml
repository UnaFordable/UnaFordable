///@description Setup
//Must be done AFTER the handover occurs, so frame after created, and after every text page change

#region Reset variables
char_count		= 0;
finishede_count = 0;
portrait_talk_c = 0;
portrait_idle_c = 0;
text_speed_c	= 0;
audio_c			= 0;
char_count_f		= 0;
effects_p		= effects[page];
text_col_p		= text_col[page];

text_speed_al	= array_length(text_speed[page])/2;
effects_al		= array_length(effects[page])/2;
text_col_al		= array_length(text_col[page])/2;

if(portrait[page] == -1){
	pos_x			= (gb_diff/2);
	finishede_x		= pos_x + box_width - x_buffer;
} else {
	pos_x			= (gb_diff/2)+(portrait_width/2);
	finishede_x		= pos_x + box_width - x_buffer;
}

draw_set_font(font[page]);
char_size = string_width("M");		//gets new charSize under current font
char_height = string_height("M");	//same for width
#endregion

#region GET THE BREAKPOINTS AND TEXT EFFECTS
//Again only need to do this if our CURRENT page is "normal". Separated from above for readabili_ty.
if(type[page] == 0){
	text_ne = text[page]; 
	str_len = string_length(text_ne);
	
	//Get variables ready
	var _by = 0, _ty = 0, _cc = 1, _breakpoint = 0;
	var _next_space = 0, _char, _txtwidth = box_width-(2*x_buffer), _char_max = _txtwidth div char_size;

	//Reset the text effects and breakpoints arrays
	text_effects = -1;
	breakpoints = -1;
	
	//Loop through and save the effect positions and breakpoints
	repeat(str_len){
		//Save Effect Positions
		_char = string_char_at(text[page], _cc);
		
		//Get next space, deal with new lines
		if(_cc >= _next_space){
			_next_space = _cc;
			while(_next_space < str_len and string_copy(text_ne, _next_space,1) != " ") _next_space++;
			var _linewidth = (_next_space-_breakpoint)*char_size;
			if (_linewidth >= _txtwidth) { _breakpoint = _cc; breakpoints[_by] = _cc; _by++; } 
		}
	
		_cc++;
	}
}
#endregion
			
#region Get the emotes
if(emotes != -1 and emotes[page] != -1){
	var sp = speaker[page]; var ep = emotes[page];
	var obj = instance_create_layer(sp.x,sp.y-sp.sprite_height-2,"Text",obj_emote);
	var spr = emote_sprite;
	with(obj){
		sprite_index = spr;
		image_index = ep;
		creator = sp;
		mode = 1;
	}
}
#endregion