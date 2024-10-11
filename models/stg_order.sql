    with orders as (
        select
            id as order_id,
            customer_id,
            orderdate as order_date,
            is_active as order_is_active
        from
            MYDB.DBT.ORDERS
)

select * from orders
