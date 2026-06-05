/*
 * Copyright (c) 2026 Dinh Thoai Tran <zinospetrel@sdf.org>
 * All rights reserved.
 *
 * + Source URL: https://github.com/progorker/mysterry/
 *
 * + License: GPL-2.0
 */

drop function if exists sterry_valid_json;
delimiter $$
create function sterry_valid_json( p_input varchar(8192) )
returns int
deterministic
sql security invoker
begin
  declare v_output varchar(8192);
  if p_input is null then
    return 0;
  else
    set v_output = trim( p_input );
  end if;
  if length( v_output ) = 0 then
    return 0;
  end if;
  if instr( v_ouput, '{' ) <= 0 then
    return 0;
  end if;
  if instr( v_ouput, '}' ) <= 0 then
    return 0;
  end if;
  return 1;
end;$$
delimiter ;