create or replace package test_apex_page_items is
  --%suite(Tests für APEX Pages, Items und Supporting Objects)

  --%test(Dynamic actions must have an explicit name)
  procedure da_must_have_an_explizit_name;
end test_apex_page_items;
/