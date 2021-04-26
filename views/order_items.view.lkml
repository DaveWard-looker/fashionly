include: "system_fields.view"
view: order_items {
  extends: [system_fields]
  sql_table_name: `thelook.order_items`
    ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: timestamp
    sql: ${TABLE}.delivered_at ;;
  }

  dimension_group: shipping {
    type: duration
    intervals: [hour,day,week]
    sql_start: ${shipped_raw} ;;
    sql_end: ${delivered_raw} ;;
  }

  dimension_group: picked {
    type: duration
    intervals: [hour,day,week]
    sql_start: ${created_raw}  ;;
    sql_end: ${shipped_raw} ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    hidden: yes
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: timestamp
    sql: cast(${TABLE}.shipped_at as timestamp)  ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    label: "Count of Order Items"
    type: count
  }

  dimension: location {
    hidden: yes
  }

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd
  }

  measure: count_of_returns {
    type: count
    filters: [status: "Returned"]
  }

  measure: count_of_cancellations {
    type: count
    filters: [status: "Cancelled"]
  }

  measure: return_rate {
    type: number
    sql: 1.00*${count_of_returns}/nullif(${count},0) ;;
    value_format_name: percent_2
  }

  measure: cancellation_rate {
    type: number
    sql: 1.00*${count_of_cancellations}/nullif(${count},0) ;;
    value_format_name: percent_2
  }

  measure: average_shipping_days {
    type: average
    sql: ${days_shipping} ;;
    value_format_name: decimal_2
  }

  measure: average_picking_hours {
    type: average
    sql: ${hours_picked} ;;
    value_format_name: decimal_2
  }

}
