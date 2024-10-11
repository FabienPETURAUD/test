{{config (
    materialized="table"
)}}

CREATE OR REPLACE TRANSIENT TABLE CUSTOMER_DIM AS (

    with customers as (
        select
            id as customer_id,
            firstname as customer_firstname,
            lastname as customer_lastname
        from
            MYDB.DBT.CUSTOMER
    ),

    orders as (
        select
            id as order_id,
            customer_id,
            orderdate as order_date,
            is_active as order_is_active
        from
            MYDB.DBT.ORDERS
    ),

    customer_orders as (
        select
            customer_id,
            min(orderdate) as orderdate_min,
            max(orderdate) as orderdate_max,
            count(id) as order_nb
        from
            MYDB.DBT.ORDERS
        group by 1

    ),

    final as (
        select
            c.customer_id,
            c.customer_firstname,
            c.customer_lastname,
            co.orderdate_min,
            co.orderdate_max,
            co.order_nb
        from 
            customers c
        left join
            customer_orders co
        on
            c.customer_id = co.customer_id

    )

    select * from final
)