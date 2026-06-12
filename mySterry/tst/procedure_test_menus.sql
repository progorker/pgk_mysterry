/*
 * Copyright (c) 2026 Dinh Thoai Tran <zinospetrel@sdf.org>
 * All rights reserved.
 *
 * + Source URL: https://github.com/progorker/pgk_mysterry/
 *
 * + License: GPL-2.0
 */

drop procedure if exists test_menus;
delimiter $$
create procedure test_menus( in p_token varchar(36), in p_suite_code varchar(640), in p_tested_db varchar(1024) )
sql security invoker
begin
  declare v_suite_id int;
  declare v_case_id int;
  declare v_test_id int;
  declare v_error_message text;
  declare v_in_menu longtext;
  declare v_in_fetch_temp int;

  declare exit handler for sqlexception
  begin
    get diagnostics condition 1 v_error_message = message_text;
    call mytestorproxy.api_testor_suite_case( p_token, v_suite_id, v_case_id, p_suite_code, 'test_menus' );
    call mytestorproxy.api_testor_error( p_token, v_test_id, v_suite_id, v_case_id, 'exception', v_error_message );
  end;

  call mytestorproxy.api_testor_suite_case( p_token, v_suite_id, v_case_id, p_suite_code, 'test_menus' );

  set v_in_menu = 'miHello world\t\t\t\t\t\r\n';
  set v_in_menu = concat( v_in_menu, 'mmHome\t\t\t\t\t\r\n' );
  set v_in_fetch_temp = 1;

  call sterry_parse_menu( v_in_menu, v_in_fetch_temp );

  call mytestorproxy.api_testor_cell_same( p_token, v_test_id, v_suite_id, v_case_id, 'type.1', concat( p_tested_db, '.temp_menu_items' ), '`type`', '', 'order by `id` asc', 'limit 0, 1', 'mi' );
  call mytestorproxy.api_testor_cell_same( p_token, v_test_id, v_suite_id, v_case_id, 'display.1', concat( p_tested_db, '.temp_menu_items' ), '`display`', '', 'order by `id` asc', 'limit 0, 1', sterry_escape('Hello world') );
  call mytestorproxy.api_testor_cell_same( p_token, v_test_id, v_suite_id, v_case_id, 'path.1', concat( p_tested_db, '.temp_menu_items' ), '`path`', '', 'order by `id` asc', 'limit 0, 1', '__PATH__' );
  call mytestorproxy.api_testor_cell_same( p_token, v_test_id, v_suite_id, v_case_id, 'host.1', concat( p_tested_db, '.temp_menu_items' ), '`host`', '', 'order by `id` asc', 'limit 0, 1', '__HOST__' );
  call mytestorproxy.api_testor_cell_same( p_token, v_test_id, v_suite_id, v_case_id, 'port.1', concat( p_tested_db, '.temp_menu_items' ), '`port`', '', 'order by `id` asc', 'limit 0, 1', '__PORT__' );
  call mytestorproxy.api_testor_cell_same( p_token, v_test_id, v_suite_id, v_case_id, 'auth.1', concat( p_tested_db, '.temp_menu_items' ), '`auth`', '', 'order by `id` asc', 'limit 0, 1', '__AUTH__' );
  call mytestorproxy.api_testor_cell_same( p_token, v_test_id, v_suite_id, v_case_id, 'json.1', concat( p_tested_db, '.temp_menu_items' ), '`json`', '', 'order by `id` asc', 'limit 0, 1', sterry_escape('__JSON__') );

  call mytestorproxy.api_testor_cell_same( p_token, v_test_id, v_suite_id, v_case_id, 'type.2', concat( p_tested_db, '.temp_menu_items' ), '`type`', '', 'order by `id` asc', 'limit 1, 1', 'mm' );
  call mytestorproxy.api_testor_cell_same( p_token, v_test_id, v_suite_id, v_case_id, 'display.2', concat( p_tested_db, '.temp_menu_items' ), '`display`', '', 'order by `id` asc', 'limit 1, 1', sterry_escape('Home') );
  call mytestorproxy.api_testor_cell_same( p_token, v_test_id, v_suite_id, v_case_id, 'path.2', concat( p_tested_db, '.temp_menu_items' ), '`path`', '', 'order by `id` asc', 'limit 1, 1', '__PATH__' );
  call mytestorproxy.api_testor_cell_same( p_token, v_test_id, v_suite_id, v_case_id, 'host.2', concat( p_tested_db, '.temp_menu_items' ), '`host`', '', 'order by `id` asc', 'limit 1, 1', '__HOST__' );
  call mytestorproxy.api_testor_cell_same( p_token, v_test_id, v_suite_id, v_case_id, 'port.2', concat( p_tested_db, '.temp_menu_items' ), '`port`', '', 'order by `id` asc', 'limit 1, 1', '__PORT__' );
  call mytestorproxy.api_testor_cell_same( p_token, v_test_id, v_suite_id, v_case_id, 'auth.2', concat( p_tested_db, '.temp_menu_items' ), '`auth`', '', 'order by `id` asc', 'limit 1, 1', '__AUTH__' );
  call mytestorproxy.api_testor_cell_same( p_token, v_test_id, v_suite_id, v_case_id, 'json.2', concat( p_tested_db, '.temp_menu_items' ), '`json`', '', 'order by `id` asc', 'limit 1, 1', sterry_escape('__JSON__') );

end;$$
delimiter ;
