import 'dart:core';
import 'dart:ui';

const server_http_address = 'https://app.sartex.am/mix/mservice.php';
final server_uri = Uri.parse(server_http_address);

const route_root = '/';
const route_dashboard = 'dashboard';

const key_error = 'key_error';
const key_empty = 'empty';
const key_session_id = 'session';

const key_user_branch = 'key_user_branch';
const key_user_is_active = 'key_user_is_active';
const key_user_firstname = 'key_user_firstname';
const key_user_lastname = 'key_user_lastname';
const key_user_position = 'key_user_position';
const key_user_role = 'key_user_role';
const key_full_name = "key_full_name";

const color_header_background = Color(0xff302d38);
const color_menu_background = Color(0xff302d38);
const color_datagrid_odd = Color(0xffffffff);
const color_datagrid_even = Color(0xffdae0ff);
const color_table_header = Color(0xff777777);
const color_table_header_border = Color(0xff362c2c);