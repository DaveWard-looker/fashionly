view: dt_users_per_shipping {
  derived_table: {
    sql: SELECT
    shipped_at, count(user_id) as count_of_users
    FROM `thelook.order_items` o
    WHERE
    {% condition order_status%} o.status {% endcondition %}
    group by 1
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  filter: order_status {
    type: string
  }

  dimension: shipped_at {
    type: date
    datatype: date
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: count_of_users {
    type: number
    sql: ${TABLE}.count_of_users ;;
  }

  set: detail {
    fields: [shipped_at, count_of_users]
  }
}
