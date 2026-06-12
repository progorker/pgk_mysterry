/*
 * Copyright (c) 2026 Dinh Thoai Tran <zinospetrel@sdf.org>
 * All rights reserved.
 *
 * + Source URL: https://github.com/progorker/pgk_mysterry/
 *
 * + License: GPL-2.0
 */

call mytestorproxy.api_testor_version( @g_token, @g_suite_id, @g_last_version );
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @g_src_dir, 'src_dir', false );

set @v_name = 'pkg_setup-api';
set @v_data = '/setup-api.sql';
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @v_data, concat('src:', @v_name), false );

set @v_name = 'pkg_setup-functions';
set @v_data = '/setup-functions.sql';
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @v_data, concat('src:', @v_name), false );

set @v_name = 'pkg_setup-procedures';
set @v_data = '/setup-procedures.sql';
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @v_data, concat('src:', @v_name), false );

set @v_name = 'pkg_setup-tables';
set @v_data = '/setup-tables.sql';
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @v_data, concat('src:', @v_name), false );

set @v_name = 'pkg_setup-tests';
set @v_data = '/setup-tests.sql';
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @v_data, concat('src:', @v_name), false );

set @v_name = 'pkg_setup';
set @v_data = '/setup.sql';
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @v_data, concat('src:', @v_name), false );

set @v_name = 'pkg_tests';
set @v_data = '/tests.sql';
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @v_data, concat('src:', @v_name), false );

set @v_name = 'pkg_tests-config';
set @v_data = '/tests-config.sql';
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @v_data, concat('src:', @v_name), false );

set @v_name = 'pkg_tests-source';
set @v_data = '/tests-source.sql';
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @v_data, concat('src:', @v_name), false );


set @v_name = 'sterry_escape';
set @v_data = '/function/function_sterry_escape.sql';
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @v_data, concat('src:', @v_name), false );

set @v_name = 'sterry_unescape';
set @v_data = '/function/function_sterry_unescape.sql';
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @v_data, concat('src:', @v_name), false );

set @v_name = 'sterry_valid_host';
set @v_data = '/function/function_sterry_valid_host.sql';
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @v_data, concat('src:', @v_name), false );

set @v_name = 'sterry_valid_port';
set @v_data = '/function/function_sterry_valid_port.sql';
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @v_data, concat('src:', @v_name), false );

set @v_name = 'sterry_valid_auth';
set @v_data = '/function/function_sterry_valid_auth.sql';
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @v_data, concat('src:', @v_name), false );

set @v_name = 'sterry_valid_json';
set @v_data = '/function/function_sterry_valid_json.sql';
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @v_data, concat('src:', @v_name), false );

set @v_name = 'sterry_valid_path';
set @v_data = '/function/function_sterry_valid_path.sql';
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @v_data, concat('src:', @v_name), false );

set @v_name = 'sterry_parse_request';
set @v_data = '/procedure/procedure_sterry_parse_request.sql';
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @v_data, concat('src:', @v_name), false );

set @v_name = 'sterry_merge_request';
set @v_data = '/procedure/procedure_sterry_merge_request.sql';
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @v_data, concat('src:', @v_name), false );

set @v_name = 'sterry_proxy';
set @v_data = '/procedure/procedure_sterry_proxy.sql';
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @v_data, concat('src:', @v_name), false );

set @v_name = 'sterry_proxy_mytestorproxy';
set @v_data = '/procedure/procedure_sterry_proxy_mytestorproxy.sql';
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @v_data, concat('src:', @v_name), false );


set @v_name = 'test_requests';
set @v_data = '/tst/procedure_test_requests.sql';
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @v_data, concat('src:', @v_name), false );

set @v_name = 'test_menus';
set @v_data = '/tst/procedure_test_menus.sql';
call mytestorproxy.api_testor_option( @g_token, @g_suite_id, @v_data, concat('src:', @v_name), false );

