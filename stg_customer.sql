with customers as (
        select
            id as customer_id,
            firstname as customer_firstname,
            lastname as customer_lastname
        from
            MYDB.DBT.CUSTOMER
)

select * from customers