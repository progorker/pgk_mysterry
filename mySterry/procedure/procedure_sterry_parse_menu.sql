/*
 * Copyright (c) 2026 Dinh Thoai Tran <zinospetrel@sdf.org>
 * All rights reserved.
 *
 * + Source URL: https://github.com/progorker/pgk_mysterry/
 *
 * + License: GPL-2.0
 */

drop procedure if exists sterry_parse_menu;
delimiter $$
create procedure sterry_parse_menu (
  in p_in_menu longtext,
  in p_in_fetch_temp int
)
sql security invoker
begin
  declare v_idx bigint;
  declare v_menu longtext;
  declare v_line longtext;
  declare v_type varchar(2);
  declare v_display varchar(1024);
  declare v_path varchar(1024);
  declare v_host varchar(1024);
  declare v_port varchar(36);
  declare v_auth varchar(256);
  declare v_json varchar(1024);
  declare v_idx_2 bigint;

  drop temporary table if exists temp_menu_items;
  create temporary table temp_menu_items (
    `id` bigint not null auto_increment primary key,
    `type` varchar(2) not null,
    `display` varchar(1024) not null,
    `path` varchar(1024) not null,
    `host` varchar(1024) not null,
    `port` varchar(36) not null,
    `auth` varchar(256) not null,
    `json` varchar(1024) not null
  );

  set v_menu = p_in_menu;

  set v_idx = instr( v_menu, '\r\n' );
  while v_idx > 0 do
    set v_line = substring_index( v_menu, '\r\n', 1 );
    set v_menu = substring( v_menu, v_idx + 2 );
    set v_idx = instr( v_menu, '\r\n' );

    set v_type = '';
    set v_display = '';
    set v_path = '';
    set v_host = '';
    set v_port = '';
    set v_auth = '';
    set v_json = '';

    if length( trim( v_line ) ) > 2 then
      set v_type = left(v_line, 2);
      set v_line = substring( v_line, 3 );
      set v_idx_2 = instr( v_line, '\t' );
      if v_idx_2 > 0 then
        set v_display = substring_index( v_line, '\t', 1 );
        set v_display = sterry_unescape( v_display );
        set v_line = substring( v_line, v_idx_2 + 1 );
        set v_idx_2 = instr( v_line, '\t' );
      end if;
      if v_idx_2 > 0 then
        set v_path = substring_index( v_line, '\t', 1 );
        set v_line = substring( v_line, v_idx_2 + 1 );
        set v_idx_2 = instr( v_line, '\t' );
      end if;
      if v_idx_2 > 0 then
        set v_host = substring_index( v_line, '\t', 1 );
        set v_line = substring( v_line, v_idx_2 + 1 );
        set v_idx_2 = instr( v_line, '\t' );
      end if;
      if v_idx_2 > 0 then
        set v_port = substring_index( v_line, '\t', 1 );
        set v_line = substring( v_line, v_idx_2 + 1 );
        set v_idx_2 = instr( v_line, '\t' );
      end if;
      if v_idx_2 > 0 then
        set v_auth = substring_index( v_line, '\t', 1 );
        set v_line = substring( v_line, v_idx_2 + 1 );
        set v_idx_2 = instr( v_line, '\t' );
      end if;
      if v_idx_2 > 0 then
        set v_json = substring_index( v_line, '\t', 1 );
        set v_json = sterry_unescape( v_json );
        set v_line = substring( v_line, v_idx_2 + 1 );
        set v_idx_2 = instr( v_line, '\t' );
      end if;
      if v_type = 'mi' then
        set v_path = '__PATH__';
        set v_host = '__HOST__';
        set v_port = '__PORT__';
        set v_auth = '__AUTH__';
        set v_json = '__JSON__';
      end if;
      if v_type = 'mm' then
        if sterry_valid_host( v_host ) = 0 then
          set v_host = '__HOST__';
        end if;
        if sterry_valid_port( v_port ) = 0 then
          set v_port = '__PORT__';
        end if;
        if sterry_valid_auth( v_auth ) = 0 then
          set v_auth = '__AUTH__';
        end if;
        if sterry_valid_json( v_json ) = 0 then
          set v_json = '__JSON__';
        end if;
        if sterry_valid_path( v_path ) = 0 then
          set v_path = '__PATH__';
        end if;
      end if;
      insert into `temp_menu_items` ( `type`, `display`, `path`, `host`, `port`, `auth`, `json` ) values ( v_type, sterry_escape( v_display ), v_path, v_host, v_port, v_auth, sterry_escape( v_json ) );
    end if;
  end while;

  if p_in_fetch_temp = 0 then
    select `id`, `type`, `display`, `host`, `port`, `auth`, `json` from `temp_menu_items` order by `id` asc;
    drop temporary table if exists temp_menu_items;
  end if;
end;$$
delimiter ;