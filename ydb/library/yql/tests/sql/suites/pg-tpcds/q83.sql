--!syntax_pg
--TPC-DS Q83

-- start query 1 in stream 0 using template ../query_templates/query83.tpl
with sr_items as
 (select i_item_id item_id,
        sum(sr_return_quantity) sr_item_qty
 from plato.store_returns,
      plato.item,
      plato.date_dim
 where sr_item_sk = i_item_sk
 and   d_date    in 
	(select d_date
	from plato.date_dim
	where d_week_seq in 
		(select d_week_seq
		from plato.date_dim
	  where d_date in ('1998-01-02'::date,'1998-10-15'::date,'1998-11-10'::date)))
 and   sr_returned_date_sk   = d_date_sk
 group by i_item_id),
 cr_items as
 (select i_item_id item_id,
        sum(cr_return_quantity) cr_item_qty
 from plato.catalog_returns,
      plato.item,
      plato.date_dim
 where cr_item_sk = i_item_sk
 and   d_date    in 
	(select d_date
	from plato.date_dim
	where d_week_seq in 
		(select d_week_seq
		from plato.date_dim
	  where d_date in ('1998-01-02'::date,'1998-10-15'::date,'1998-11-10'::date)))
 and   cr_returned_date_sk   = d_date_sk
 group by i_item_id),
 wr_items as
 (select i_item_id item_id,
        sum(wr_return_quantity) wr_item_qty
 from plato.web_returns,
      plato.item,
      plato.date_dim
 where wr_item_sk = i_item_sk
 and   d_date    in 
	(select d_date
	from plato.date_dim
	where d_week_seq in 
		(select d_week_seq
		from plato.date_dim
		where d_date in ('1998-01-02'::date,'1998-10-15'::date,'1998-11-10'::date)))
 and   wr_returned_date_sk   = d_date_sk
 group by i_item_id)
  select  sr_items.item_id
       ,sr_item_qty
       ,sr_item_qty::numeric/(sr_item_qty+cr_item_qty+wr_item_qty)::numeric/3.0::numeric * 100::numeric sr_dev
       ,cr_item_qty
       ,cr_item_qty::numeric/(sr_item_qty+cr_item_qty+wr_item_qty)::numeric/3.0::numeric * 100::numeric cr_dev
       ,wr_item_qty
       ,wr_item_qty::numeric/(sr_item_qty+cr_item_qty+wr_item_qty)::numeric/3.0::numeric * 100::numeric wr_dev
       ,(sr_item_qty+cr_item_qty+wr_item_qty)::numeric/3.0::numeric average
 from sr_items
     ,cr_items
     ,wr_items
 where sr_items.item_id=cr_items.item_id
   and sr_items.item_id=wr_items.item_id 
 order by sr_items.item_id
         ,sr_item_qty
 limit 100;

-- end query 1 in stream 0 using template ../query_templates/query83.tpl
