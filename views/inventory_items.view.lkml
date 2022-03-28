include: "system_fields.view"
view: inventory_items {
  extends: [system_fields]
  # sql_table_name: `thelook.inventory_items`
  derived_table: {
    sql:  SELECT * FROM
 {% if created_week._in_query %}
 ${inventory_items_by_week.SQL_TABLE_NAME} i
 {% elsif created_month._in_query %}
 ${inventory_items_by_month.SQL_TABLE_NAME} i
 {% elsif created_year._in_query %}
 ${inventory_items_by_year.SQL_TABLE_NAME} i
 {% else %}
 thelook.inventory_items i
 {% endif %}
where

{% condition product_category  %} i.product_category {% endcondition %}

    ;;
    }
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
}
