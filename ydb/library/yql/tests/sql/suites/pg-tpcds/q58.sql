--!syntax_pg
--TPC-DS Q58

-- start query 1 in stream 0 using template ../query_templates/query58.tpl
with ss_items as
 (select i_item_id item_id
        ,sum(ss_ext_sales_price) ss_item_rev 
 from plato.store_sales
     ,plato.item
     ,plato.date_dim
 where ss_item_sk = i_item_sk
   and d_date in (select d_date
                  from plato.date_dim
                  where d_week_seq = (select d_week_seq 
                                      from plato.date_dim
                                      where d_date = '1998-02-19'::date))
   and ss_sold_date_sk   = d_date_sk
 group by i_item_id),
 cs_items as
 (select i_item_id item_id
        ,sum(cs_ext_sales_price) cs_item_rev
  from plato.catalog_sales
      ,plato.item
      ,plato.date_dim
 where cs_item_sk = i_item_sk
  and  d_date in (select d_date
                  from plato.date_dim
                  where d_week_seq = (select d_week_seq 
                                      from plato.date_dim
                                      where d_date = '1998-02-19'::date))
  and  cs_sold_date_sk = d_date_sk
 group by i_item_id),
 ws_items as
 (select i_item_id item_id
        ,sum(ws_ext_sales_price) ws_item_rev
  from plato.web_sales
      ,plato.item
      ,plato.date_dim
 where ws_item_sk = i_item_sk
  and  d_date in (select d_date
                  from plato.date_dim
                  where d_week_seq =(select d_week_seq 
                                     from plato.date_dim
                                     where d_date = '1998-02-19'::date))
  and ws_sold_date_sk   = d_date_sk
 group by i_item_id)
  select  ss_items.item_id
       ,ss_item_rev
       ,ss_item_rev/((ss_item_rev+cs_item_rev+ws_item_rev)/3::numeric) * 100::numeric ss_dev
       ,cs_item_rev
       ,cs_item_rev/((ss_item_rev+cs_item_rev+ws_item_rev)/3::numeric) * 100::numeric cs_dev
       ,ws_item_rev
       ,ws_item_rev/((ss_item_rev+cs_item_rev+ws_item_rev)/3::numeric) * 100::numeric ws_dev
       ,(ss_item_rev+cs_item_rev+ws_item_rev)/3::numeric average
 from ss_items,cs_items,ws_items
 where ss_items.item_id=cs_items.item_id
   and ss_items.item_id=ws_items.item_id 
   and ss_item_rev between 0.9::numeric * cs_item_rev and 1.1::numeric * cs_item_rev
   and ss_item_rev between 0.9::numeric * ws_item_rev and 1.1::numeric * ws_item_rev
   and cs_item_rev between 0.9::numeric * ss_item_rev and 1.1::numeric * ss_item_rev
   and cs_item_rev between 0.9::numeric * ws_item_rev and 1.1::numeric * ws_item_rev
   and ws_item_rev between 0.9::numeric * ss_item_rev and 1.1::numeric * ss_item_rev
   and ws_item_rev between 0.9::numeric * cs_item_rev and 1.1::numeric * cs_item_rev
 order by item_id
         ,ss_item_rev
 limit 100;

-- end query 1 in stream 0 using template ../query_templates/query58.tpl
