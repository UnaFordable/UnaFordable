
if(instance_number(obj_textevent)>1 or instance_number(obj_textbox)>0){ instance_destroy(); exit; }

//-----------Customise (FOR USER)
my_voice			= snd_voice2;
my_text_col		= c_white;
my_portrait		= -1;
my_font			= fnt_dialogue;
my_name			= "None";

//-----------Setup (LEAVE THIS STUFF)
my_textbox   = noone;
reset_dialogue_defaults();