/*
 * Copyright (c) 2026 Dinh Thoai Tran <zinospetrel@sdf.org>
 * All rights reserved.
 *
 * + Source URL: https://github.com/progorker/pgk_mysterry/
 *
 * + License: GPL-2.0
 */

drop procedure if exists sterry_proxy;
delimiter $$
create procedure sterry_proxy (
  in p_code varchar(640),
  in p_input_json longtext,
  out p_output_json longtext
)
sql security invoker
begin
  call sterry_proxy_mytestorproxy( p_code, p_input_json, p_output_json );
end;$$
delimiter ;