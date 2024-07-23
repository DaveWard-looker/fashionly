
include: "system_fields.view"
view: inventory_items {
  extends: [system_fields]
  sql_table_name:
{% if created_week._in_query %}
${inventory_items_by_week.SQL_TABLE_NAME}
{% elsif created_month._in_query %}
${inventory_items_by_month.SQL_TABLE_NAME}
{% elsif created_year._in_query %}
${inventory_items_by_year.SQL_TABLE_NAME}
{% else %}
thelook.inventory_items
{% endif %}
  ;;

  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    hidden: yes
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension_group: created {
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
    datatype: date
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_brand {
    type: string
    sql: ${TABLE}.product_brand ;;
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}.product_category ;;
  }

  dimension: product_department {
    type: string
    sql: ${TABLE}.product_department ;;
  }

  dimension: product_distribution_center_id {
    type: number
    sql: ${TABLE}.product_distribution_center_id ;;
  }

  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: product_retail_price {
    hidden: yes
    type: number
    sql: ${TABLE}.product_retail_price ;;
  }

  dimension: product_sku {
    type: string
    sql: ${TABLE}.product_sku ;;
  }

  dimension: location {
    hidden: yes
  }

  parameter: sold_at_timeframe {
    type: unquoted
    allowed_value: {
      label: "By Day"
      value: "day"
    }
    allowed_value: {
      label: "By Week"
      value: "week"
    }
    allowed_value: {
      label: "By Month"
      value: "month"
    }
    allowed_value: {
      label: "By Year"
      value: "year"
    }
  }

  dimension: timeframe {
    label_from_parameter: sold_at_timeframe
    type: string
    sql:
    {% if sold_at_timeframe._parameter_value == 'day' %}
    ${sold_date}
    {% elsif sold_at_timeframe._parameter_value == 'week' %}
    ${sold_week}
    {% elsif sold_at_timeframe._parameter_value == 'month' %}
    ${sold_month}
    {% else %}
    ${sold_year}
    {% endif %}
    ;;
  }


  parameter: aggregate_value {
    type: unquoted
    allowed_value: {
      label: "By Total Cost"
      value: "cost"
    }
    allowed_value: {
      label: "By Product Retail Price"
      value: "product_retail_price"
    }
  }

  measure: display_value {
    label_from_parameter: aggregate_value
    type: sum
    sql: ${TABLE}.{{ aggregate_value._parameter_value }} ;;
  }

  dimension_group: sold {
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
    sql: ${TABLE}.sold_at ;;
  }

  dimension_group: warehoused {
    type: duration
    intervals: [day,week,month]
    sql_start: ${created_raw} ;;
    sql_end: ${sold_raw} ;;
  }

  measure: count {
    label: "Count of Inventory Items"
    type: count
    drill_fields: [id, product_name, products.name, products.id, order_items.count]
  }

  measure: total_cost {
    type: sum
    sql: ${cost} ;;
    value_format_name: usd
  }

  measure: total_product_retail_price {
    type: sum
    sql: ${product_retail_price} ;;
    value_format_name: usd
  }

  measure: average_product_retail_price {
    type: average
    sql: ${product_retail_price} ;;
    value_format_name: usd
  }

  measure: count_of_skus {
    type: count_distinct
    sql: ${product_sku} ;;
  }
}
