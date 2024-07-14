/// @description Dialogue Choice
//This is made to be an alarm so we can have a small "pause" after selecting a dialogue option

#region Update choice and page

//Change an object's variable according to choice if applicable
var _cv = execute_script[page];
if(is_array(_cv)){
	_cv = _cv[choice];
	var _len = array_length(_cv)-1;
	var _cva = array_create(_len, 0);
	array_copy(_cva, 0, _cv, 1, _len); 
	script_execute_alt(_cv[0], _cva);
}

//Update page
if(page+1 < array_length(text)){
	var _nl = nextline[page];
	switch(_nl[choice]){
		case -1: instance_destroy();	exit;
		case  0: page += 1;				break;
		default: page = _nl[choice];
	}
	event_perform(ev_alarm, 0);
	
} else {
	instance_destroy();	
}

chosen = false;

#endregion