/*
 * Copyright (c) 2026 Dinh Thoai Tran <zinospetrel@sdf.org>
 * All rights reserved.
 *
 * + Source URL: https://github.com/progorker/pgk_mysterry/
 *
 * + License: GPL-2.0
 */

drop procedure if exists sterry_parse_request;
delimiter $$
create procedure sterry_parse_request (
  in p_request longtext,
  out p_host varchar(8192),
  out p_port int,
  out p_auth_token varchar(8192),
  out p_json_data longtext,
  out p_path varchar(8192)
)
sql security invoker
begin
  declare v_tmp longtext;
  declare v_item varchar(8192);
  declare v_idx bigint;
  set p_host = '';
  set p_port = -1;
  set p_auth_token = '';
  set p_json_data = '{}';
  set p_path = '/';

  set v_idx = instr( p_request, '\r\n' );
  if v_idx > 0 then
    set p_host = trim( substring_index( p_request, '\r\n', 1 ) );
    set v_tmp = substring( p_request, v_idx + 2 );
    set v_idx = instr( v_tmp, '\r\n' );
  end if;
  if v_idx > 0 then
    set v_item = trim( substring_index( v_tmp, '\r\n', 1 ) );
    select case when v_item regexp '^[0-9]+$' then cast( v_item as signed ) else -1 end into p_port;
    set v_tmp = substring( v_tmp, v_idx + 2 );
    set v_idx = instr( v_tmp, '\r\n' );
  end if;
  if v_idx > 0 then
    set p_auth_token = trim( substring_index( v_tmp, '\r\n', 1 ) );
    set v_tmp = substring( v_tmp, v_idx + 2 );
    set v_idx = instr( v_tmp, '\r\n' );
  end if;
  if v_idx > 0 then
    set p_json_data = sterry_unescape( trim( substring_index( v_tmp, '\r\n', 1 ) ) );
    set v_tmp = substring( v_tmp, v_idx + 2 );
    set v_idx = instr( v_tmp, '\r\n' );
    if p_json_data = '' then
      set p_json_data = '{}';
    end if;
    set p_json_data = sterry_unescape(p_json_data);
  end if;
  if v_idx > 0 then
    set p_path = trim( substring_index( v_tmp, '\r\n', 1 ) );
    set v_tmp = substring( v_tmp, v_idx + 2 );
    set v_idx = instr( v_tmp, '\r\n' );
    if p_path = '' then
      set p_path = '/';
    end if;
  end if;
end;$$
delimiter ;