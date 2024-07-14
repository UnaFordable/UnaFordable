var _cv = execute_script[page];
if(is_array(_cv)){
	var _len = array_length(_cv)-1;
	var _cva = array_create(_len, 0);
	array_copy(_cva, 0, _cv, 1, _len);
	var _c = _cva;
	script_execute_alt(_cv[0], _cva);
}