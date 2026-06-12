/*
 * Copyright (c) 2026 Dinh Thoai Tran <zinospetrel@sdf.org>
 * All rights reserved.
 *
 * + Source URL: https://github.com/progorker/pgk_mysterry/
 *
 * + License: GPL-2.0
 */

drop procedure if exists sterry_merge_request;
delimiter $$
create procedure sterry_merge_request (
  out p_request longtext,
  in p_host varchar(8192),
  in p_port int,
  in p_auth_token varchar(8192),
  in p_json_data longtext,
  in p_path varchar(8192)
)
sql security invoker
begin
  set p_request = concat( p_host, '\r\n', p_port, '\r\n', p_auth_token, '\r\n', sterry_escape(p_json_data), '\r\n', p_path, '\r\n\r\n' );
end;$$
delimiter ;