//---You can update variables here!---//
reset_dialogue_defaults();


switch(choice_variable){
	case -1:
	#region First Dialogue
		//Line 0
		var _i = 0;
		my_text[_i]		= "You can run a script after any line of dialogue! Let's make an emote to the left.";
		my_speaker[_i]	= id;
		my_scripts[_i]	= [create_instance_layer, 170,120,"Instances",obj_emote];
		
		//Line 1
		_i++;
		my_text[_i]		= "You can even have it depend on player choice. Which object should _i make?";
		my_speaker[_i]	= id;
		
		//Line 2
		_i++;
		my_text[_i]		= ["An emote", "Another you!"];
		my_types[_i]		= 1;
		my_speaker[_i]	= obj_player;
		my_scripts[_i]	= [[create_instance_layer, 170,120,"Instances",obj_emote], [create_instance_layer, 170,120,"Instances",obj_examplechar]];
		my_next_line[_i]	= [0,0];
		
		//Line 3
		_i++;
		my_text[_i]		= "Pretty cool, right? Now, let's get back to our conversation.";
		my_speaker[_i]	= id;
		
		//Line 4
		_i++;
		my_text[_i]		= "Looky here, green hood.";
		my_effects[_i]	= [13,1, 18,0];
		my_speaker[_i]	= id;
		my_text_col[_i]	= [13, c_lime, 18, c_white];

		//Line 5
		_i++;
		my_text[_i]		= "We both know blue is the best colour.";
		my_emotion[_i]	= 1;
		my_emote[_i]		= 0;
		my_speaker[_i]	= id;
		my_text_col[_i]	= [14, c_aqua, 18, c_white];

		//Line 6
		_i++;
		my_text[_i]		= "Say it... or else.";
		my_text_speed[_i]	= [1,0.5, 10,0.1];
		my_emotion[_i]	= 0;
		my_emote[_i]		= 4;
		my_speaker[_i]	= id;
		my_text_col[_i]	= [11, c_red, 18, c_white];

		//Line 7
		_i++;
		my_text[_i]		= ["(sarcastically) Blue is the best colour.", "Green is the best colour."];
		my_types[_i]		= 1;
		my_next_line[_i]	= [8,9];
		my_scripts[_i]	= [[change_variable, id, "choice_variable", "blue"], [change_variable, id, "choice_variable", "green"]];
		my_speaker[_i]	= obj_player;

		//Line 8
		_i++;
		my_text[_i]		= "Exactly! Thank you!";
		my_emotion[_i]	= 0;
		my_emote[_i]		= 0;
		my_next_line[_i]	= -1;
		my_speaker[_i]	= id;

		//Line 9
		_i++;
		my_text[_i]		= "Nooooooooooooooooooooooo!";
		my_text_speed[_i]	= [1,1, 6,0.3, 10,1];
		my_emotion[_i]	= 2;
		my_emote[_i]		= 9;
		my_speaker[_i]	= id;
		#endregion
	break;
	
	case "green":
	#region If you chose green
		var _i = 0;
		//Line 0
		my_text[_i]		= "_i can't believe you like green better...";
		my_text_speed[_i]	= [1, 0.3];
		my_emotion[_i]	= 2;
		my_emote[_i]		= 9;
		my_speaker[_i]	= id;
		my_text_col[_i]	= [26,c_lime, 31,c_white];
		
		//uncommenting this will make the first conversation begin again
		//choice_variable	= -1;
	#endregion
	
	break;
	
	case "blue":
	#region If you chose blue
		var _i = 0;
		//Line 0
		my_text[_i]		= "Hey there, fellow blue lover!";
		my_text_speed[_i]	= [1,1, 10,0.5];
		my_emotion[_i]	= 1;
		my_emote[_i]		= 0;
		my_speaker[_i]	= id;
		my_text_col[_i]	= [19,c_aqua, 23,c_white];
		
		//uncommenting this will make the first conversation begin again
		//choice_variable	= -1;
	#endregion
	break;
}