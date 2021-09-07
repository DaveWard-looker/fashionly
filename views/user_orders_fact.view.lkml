view: user_orders_fact {
  derived_table: {
    sql: SELECT users.id,
      users.created_at as user_created,
      min(orders.created_at) as first_order,
      max(orders.created_at) as last_order,
      count(distinct orders.created_at) as number_of_orders,
      count(distinct orders.returned_at) as number_of_returns
      FROM `daveward-ps-dev.thelook.users` users
      LEFT JOIN `daveward-ps-dev.thelook.order_items` orders
      on users.id = orders.user_id
      group by 1,2
       ;;
  }

  filter: user_id {
    type: number
    suggest_dimension: users.id
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    primary_key: yes
    hidden: no
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: user_created {
    hidden: yes
    type: time
    sql: ${TABLE}.user_created ;;
  }

  dimension_group: first_order {
    hidden: yes
    type: time
    sql: ${TABLE}.first_order ;;
  }

  dimension_group: last_order {
    hidden: yes
    type: time
    sql: ${TABLE}.last_order ;;
  }

  dimension: number_of_orders {
    hidden: yes
    type: number
    sql: ${TABLE}.number_of_orders ;;
  }

  dimension: number_of_returns {
    hidden: yes
    type: number
    sql: ${TABLE}.number_of_returns ;;
  }

  dimension_group: customer {
    hidden: yes
    type: duration
    intervals: [day]
    sql_start: ${first_order_raw} ;;
    sql_end: getdate() ;;
  }

  dimension: customer_duration_tier {
    type: tier
    tiers: [90,180,270,365,730]
    sql: ${days_customer} ;;
  }

  dimension_group: active {
    hidden: yes
    type: duration
    sql_start: ${last_order_raw} ;;
    sql_end: getdate() ;;
  }

  dimension: is_active_customer {
    type: yesno
    sql: ${days_active} < 90  ;;
  }

  dimension: customer_freshness {
    type: tier
    tiers: [90,180,270,365,730]
    sql: ${days_active} ;;
  }

  measure: count_of_customer_orders {
    type: sum
    sql: ${number_of_orders} ;;
    value_format_name: decimal_0
  }

  measure: count_of_customer_returns {
    type: sum
    sql: ${number_of_orders} ;;
    value_format_name: decimal_0
  }



  set: detail {
    fields: [
      id,
      user_created_time,
      first_order_time,
      last_order_time,
      number_of_orders,
      number_of_returns
    ]
  }
}
