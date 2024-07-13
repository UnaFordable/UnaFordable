// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function reset_dialogue_defaults(){
	m_textbox = noone;
	m_text = -1;
	m_speaker = -1;
	m_effects = 0;
	m_text_speed = 0;
	m_types = 0;
	m_next_line = 0;
	m_scripts = 0;
	m_text_col = 0;
	m_emotion = 0;
	m_emote = -1;
}

function create_text_event(_text, _speaker, _effects, _speed, _type, _next_line, _scripts, _text_col, _emotion, _emote){
	if(instance_exists(obj_textevent)){ exit; }
	var _textevent = instance_create_layer(0,0,"Instances",obj_textevent);
	with(_textevent){
		reset_dialogue_defaults();
		m_emote = _emote;
		m_emotion = _emotion;
		m_text_col = _text_col;
		m_scripts = _scripts;
		m_next_line = _next_line;
		m_types	 = _type;
		m_text_speed = _speed;
		m_effects	= _effects;
		m_speaker = _speaker;
		m_text	 = _text;
		event_perform(ev_other, ev_user0);
	}
	return _textevent;
}

function create_dialog(_text, _speaker, _effects, _speed, _type, _next_line, _scripts, _text_col, _emotion, _emote){
	
	if(instance_exists(obj_textbox)){ exit; }
	//Create the Textbox
	var _textbox = instance_create_layer(x,y, "Text", obj_textbox);
	with(obj_textbox) var _dcol = default_col;

	//Get arguments
	var _text_len;

	//If Text or Speaker aren't arrays (single line input), make them arrays 
	if(is_array(_text)){
		_text_len = array_length(_text);
	}
	else{ 
		_text_len = 1; 
		_text[0] = _text;
	}
	if(!is_array(_speaker)){ 
		_speaker = array_create(_text_len, id); 
	}
	else{ }
	//Fill variables depending on argument count
	if(array_length(_emote) != _text_len){_emote[_text_len] = 0;}
	if(array_length(_emotion) != _text_len){ _emotion[_text_len] = 0; }
	if(array_length(_text_col) != _text_len){ _text_col[_text_len] = 0; }
	if(array_length(_scripts) != _text_len){ _scripts[_text_len] = -1; }
	if(array_length(_next_line) != _text_len){ _next_line[_text_len] = 0; }
	if(array_length(_type) != _text_len){ _type[_text_len] = 0; }
	if(array_length(_speed) != _text_len){ _speed[_text_len] = 0; }
	if(array_length(_effects) != _text_len){ _effects[_text_len] = 0; }

	//Change the Textbox Values
	with(_textbox){
		creator		= _creator;
		effects		= _effects;
		text_speed	= _speed;
		type		= _type;
		text		= _text;
		nextline	= _nextline;
		execute_script = _script;
		text_col	= _textcol;
		emotion		= _emotion;	
		emotes		= _emotes;
	
		//Speaker's Variables
		for(var _i = 0; _i <= _text_len; _i++){
			portrait[_i] = _speaker[_i].myPortrait;
			voice[_i] = _speaker[_i].myVoice;
			font[_i] = _speaker[_i].myFont;
			name[_i] = _speaker[_i].myName;
			speaker[_i] = _speaker[_i];
		
			if(variable_instance_exists(_speaker[i], "myPortraitTalk"))		{ portrait_talk[i] = _speaker[i].myPortraitTalk; }
			else { portrait_talk[i] = -1; }
			if(variable_instance_exists(_speaker[i], "myPortraitTalk_x"))	{ portrait_talk_x[i] = _speaker[i].myPortraitTalk_x; }
			else { portrait_talk_x[i] = -1; }
			if(variable_instance_exists(_speaker[i], "myPortraitTalk_y"))	{ portrait_talk_y[i] = _speaker[i].myPortraitTalk_y; }
			else { portrait_talk_y[i] = -1; }
			if(variable_instance_exists(_speaker[i], "myPortraitIdle"))		{ portrait_idle[i] = _speaker[i].myPortraitIdle; }
			else { portrait_idle[i] = -1; }
			if(variable_instance_exists(_speaker[i], "myPortraitIdle_x"))	{ portrait_idle_x[i] = _speaker[i].myPortraitIdle_x; }
			else { portrait_idle_x[i] = -1; }
			if(variable_instance_exists(_speaker[i], "myPortraitIdle_y"))	{ portrait_idle_y[i] = _speaker[i].myPortraitIdle_y; }
			else { portrait_idle_y[i] = -1; }
			if(portrait_talk[i] != -1){ 
				portrait_talk_n[i] = sprite_get_number(portrait_talk[i]);
				portrait_talk_s[i] = sprite_get_speed(portrait_talk[i])/room_speed;
			}
			if(portrait_idle[i] != -1){ 
				portrait_idle_n[i] = sprite_get_number(portrait_idle[i]);
				portrait_idle_s[i] = sprite_get_speed(portrait_idle[i])/room_speed;
			}
		}
		draw_set_font(font[0]);
		char_size = string_width("M");
		stringheight = string_height("M");
		event_perform(ev_alarm, 0);	//makes textbox perform "setup"
	}
	m_textbox = _textbox;
	return _textbox;
}