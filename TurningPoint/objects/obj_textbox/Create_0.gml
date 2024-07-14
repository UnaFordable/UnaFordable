/// @description Insert description here
// You can write your code in this editor

if(instance_number(obj_textevent)>1 or instance_number(obj_textbox)>1){ instance_destroy(); exit; }

//-----------Customise (FOR USER)
interact_key		= ord("E");
up_key				= vk_up;		//for dialogue choices
down_key			= vk_down;		//for dialogue choices

scale				= 1;
x_buffer			= 10 * scale;
y_buffer			= 7 * scale;

//portrait_frame		= spr_text_box;
dialogue_box		= spr_text_box;
name_box			= spr_text_box;
finished_effect		= spr_pointer;
emote_sprite		= spr_emotes;

choice_snd_effect	= snd_beep;
select_snd_effect	= snd_select;

default_col			= c_black;
choice_col			= c_yellow;
select_col			= c_orange;
name_col			= c_orange;

name_font			= fnt_ds;

priority_snd_effect = 5;
open_mouth_frame	= 0;	//You only need to change this if you are using animated sprites
							//Set this to equal the frame where the mouth is OPEN for talking sprites

//-----------Setup (LEAVE THIS STUFF)
#region Setup
portrait_talk	= -1;
portrait_talk_n = -1;
portrait_talk_s = -1;
portrait_talk_c = 0;

portrait_idle	= -1;
portrait_idle_n = -1;
portrait_idle_s = -1;
portrait_idle_c = 0;

emotes			= -1;
speaker			= noone;

box_height		= sprite_get_height(spr_text_box) * scale;
box_width		= sprite_get_width(spr_text_box) * scale;
gui_width		= display_get_gui_width();
gui_height		= display_get_gui_height();
gb_diff			= gui_width - box_width;
//portrait_width	= sprite_get_width(portrait_frame) * scale;
finishede_num	= sprite_get_number(finished_effect);
finishede_spd	= (sprite_get_speed(spr_dialoguefinished)/room_speed);

pos_x			= (gb_diff/2)+(portrait_width/2);
pos_y			= gui_height-box_height-8;

name_box_x		= pos_x + (8 * scale);
name_box_y		= pos_y - (23 * scale);
name_box_text_x = name_box_x + ((sprite_get_width(name_box)*scale)/2);
name_box_text_y = name_box_y + y_buffer;

finishede_x		= pos_x + box_width - x_buffer;
finishede_y		= pos_y + box_height - y_buffer;

letter			= 0;
char_count		= 0;
char_count_f		= 0;
text_speed		= 0;
text_speed_c	= 0;
audio_c			= 0;
page			= 0;
str_len			= -1;
pause			= false;
chosen			= false;
choice			= 0;

creator			= noone;
type			= 0;
text			= -1;
text_ne			= -1;
breakpoints		= -1;
nextline		= 0;
text_col		= c_white;
emotion			= 0;

portrait		= 1;
voice			= 1;
font			= 1;

char_size		= 1;
stringheight	= 1;

//---------------------Effect variables

t			= 0;
amplitude	= 4;
freq		= 2;
ec			= 0;	//effect c
#endregion