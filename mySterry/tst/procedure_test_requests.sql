/*
 * Copyright (c) 2026 Dinh Thoai Tran <zinospetrel@sdf.org>
 * All rights reserved.
 *
 * + Source URL: https://github.com/progorker/mysterry/
 *
 * + License: GPL-2.0
 */

drop procedure if exists test_requests;
delimiter $$
create procedure test_requests( in p_token varchar(36), in p_suite_code varchar(640) )
sql security invoker
begin
  declare v_suite_id int;
  declare v_case_id int;
  declare v_test_id int;
  declare v_error_message text;
  declare v_request longtext;
  declare v_sterry_request longtext;
  declare v_sterry_host varchar(8192);
  declare v_sterry_port int;
  declare v_sterry_auth_token varchar(8192);
  declare v_sterry_json_data longtext;
  declare v_json varchar(8192);
  declare v_sterry_path varchar(8192);

  declare exit handler for sqlexception
  begin
    get diagnostics condition 1 v_error_message = message_text;
    call mytestorproxy.api_testor_suite_case( p_token, v_suite_id, v_case_id, p_suite_code, 'test_requests' );
    call mytestorproxy.api_testor_error( p_token, v_test_id, v_suite_id, v_case_id, 'exception', v_error_message );
  end;

  call mytestorproxy.api_testor_suite_case( p_token, v_suite_id, v_case_id, p_suite_code, 'test_requests' );

  set v_request = concat( '192.168.89.203\r\n8311\r\nAZDKOGOEWGDAH\r\n', sterry_escape('{\"n\":2}'), '\r\n/testor/\r\n\r\n' );
  set v_sterry_host = '';
  set v_sterry_port = -1;
  set v_sterry_path = '';
  set v_sterry_auth_token = '';
  set v_sterry_json_data = '';

  call sterry_parse_request( v_request, v_sterry_host, v_sterry_port, v_sterry_auth_token, v_sterry_json_data, v_sterry_path );

  call mytestorproxy.api_testor_same( p_token, v_test_id, v_suite_id, v_case_id, 'host.1', v_sterry_host, '192.168.89.203' );
  call mytestorproxy.api_testor_equals( p_token, v_test_id, v_suite_id, v_case_id, 'port.1', v_sterry_port, 8311 );
  call mytestorproxy.api_testor_same( p_token, v_test_id, v_suite_id, v_case_id, 'auth_token.1', v_sterry_auth_token, 'AZDKOGOEWGDAH' );
  call mytestorproxy.api_testor_same( p_token, v_test_id, v_suite_id, v_case_id, 'json_data.1', v_sterry_json_data, '{\"n\":2}' );
  call mytestorproxy.api_testor_same( p_token, v_test_id, v_suite_id, v_case_id, 'path.1', v_sterry_path, '/testor/' );

  set v_request = concat( '192.168.89.203\r\n8311\r\nAZDKOGOEWGDAH\r\n', sterry_escape('{\"n\":2}'), '\r\n/testor/\r\n\r\n' );
  set v_sterry_request = '';
  set v_sterry_host = '192.168.89.203';
  set v_sterry_port = 8311;
  set v_sterry_auth_token = 'AZDKOGOEWGDAH';
  set v_sterry_json_data = '{\"n\":2}';
  set v_sterry_path = '/testor/';

  call sterry_merge_request( v_sterry_request, v_sterry_host, v_sterry_port, v_sterry_auth_token, v_sterry_json_data, v_sterry_path );
  call mytestorproxy.api_testor_same( p_token, v_test_id, v_suite_id, v_case_id, 'request.1', v_sterry_request, v_request );
end;$$
delimiter ;
