create or replace package body test_apex_page_items is


  -- Get DAs from APEX Catalog
  cursor apx_da (p_app_id in number) is
  select application_id, page_id, dynamic_action_name
    from apex_application_page_da
   where application_id = p_app_id
  order by page_id, dynamic_action_sequence, dynamic_action_name;



  --%test(Dynamic actions must have an explicit name)
  procedure da_must_have_an_explizit_name is
    l_ids apex_t_number := apex_string.split_numbers(test_apex_page_items_config.C_APP_IDS, ':');
  begin
    for i in 1 .. l_ids.count
    loop
      for cur in apx_da(p_app_id => l_ids(i))
      loop
        ut.expect(lower(cur.dynamic_action_name), 'Naming of Dynamic Action in App: '|| cur.application_id ||' for Page '||cur.page_id||' must not be like ''new''')
                        .not_to_be_like('new');
      end loop;
    end loop; -- app_id
  end;
end test_apex_page_items;
/