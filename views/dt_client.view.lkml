view: dt_client {
  derived_table: {
    sql: select
        user_id,
        min(created_at) as first_order_date,
        count(distinct order_id) number_of_orders,
        count(distinct id)
        number_of_items_ordered,
        sum(sale_price) as client_purchase_amount
      from thelook.order_items oi
      where
      -- if dev -- status = 'Complete'
      -- if prod -- status = 'Cancelled'
      and {% condition order_items.created_date %} oi.created_at {% endcondition %}
      group by 1
       ;;
  }


  dimension_group: client_retention_period {
    type: duration
    sql_start: ${first_order_raw} ;;
    sql_end: ${order_items.created_raw} ;;
    intervals: [day,week,month,year]
  }


  dimension: user_id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: first_order {
    type: time
    sql: ${TABLE}.first_order_date ;;
    timeframes: [raw,date]
  }

  dimension: number_of_orders {
    hidden: yes
    type: number
    sql: ${TABLE}.number_of_orders ;;
  }

  dimension: number_of_items_ordered {
    hidden: yes
    type: number
    sql: ${TABLE}.number_of_items_ordered ;;
  }

  dimension: client_purchase_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.client_purchase_amount ;;
  }

  measure: total_client_orders {
    type: sum
    sql: ${number_of_orders} ;;
    value_format_name: decimal_0
  }

  measure: total_client_items_ordered {
    type: sum
    sql: ${number_of_items_ordered} ;;
    value_format_name: decimal_0
  }

  measure: total_client_purchases {
    type: sum
    sql: ${client_purchase_amount} ;;
  }


}
