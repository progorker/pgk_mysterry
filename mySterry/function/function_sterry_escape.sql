/*
 * Copyright (c) 2026 Dinh Thoai Tran <zinospetrel@sdf.org>
 * All rights reserved.
 *
 * + Source URL: https://github.com/progorker/mysterry/
 *
 * + License: GPL-2.0
 */

drop function if exists sterry_escape;
delimiter $$
create function sterry_escape( p_input varchar(8192) )
returns varchar(8192)
deterministic
sql security invoker
begin
  declare v_output varchar(8192);
  if p_input is null then
    set v_output = 'NULL';
  else
    set v_output = p_input;
  end if;
  set v_output = replace( v_output, '''', '__sq__' );
  set v_output = replace( v_output, '\"', '__dq__' );
  set v_output = replace( v_output, '\n', '__nl__' );
  set v_output = replace( v_output, '\r', '__cr__' );
  set v_output = replace( v_output, '\t', '__tb__' );
  set v_output = replace( v_output, '\\', '__sl__' );
  return v_output;
end;$$
delimiter ;