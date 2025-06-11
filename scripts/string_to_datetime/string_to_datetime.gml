function string_to_datetime(_datetime_str) {
	var _datetime_split = string_split(_datetime_str, " ");
	var _date_string = _datetime_split[0];
	var _time_string = _datetime_split[1];

	var _date_split = string_split(_date_string, "/");
	var _day = real(_date_split[0]);
	var _month = real(_date_split[1]);
	var _year = real(_date_split[2]);
	
	var _time_split = string_split(_time_string, ":");
	var _hour = real(_time_split[0]);
	var _minute = real(_time_split[1]);
	var _second = real(_time_split[2]);

	var _datetime = date_create_datetime(_year, _month, _day, _hour, _minute, _second);
	return _datetime;
}
