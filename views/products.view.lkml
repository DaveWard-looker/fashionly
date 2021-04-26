include: "system_fields.view"
view: products {
  extends: [system_fields]
  sql_table_name: `thelook.products`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: cost {
    hidden: yes
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: distribution_center_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.distribution_center_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: retail_price {
    hidden: yes
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  dimension: location {
    hidden: yes
  }

  measure: count {
    label: "Count of Products"
    type: count
  }

  measure: total_cost {
    type: sum
    sql: ${cost} ;;
    value_format_name: usd
  }

  measure: total_price {
    type: sum
    sql: ${retail_price} ;;
    value_format_name: usd
  }

  measure: total_profit {
    type: number
    sql: ${total_price} - ${total_cost} ;;
    value_format_name: usd
  }

  measure: profit_per_customer {
    type: number
    sql: ${total_profit}/nullif(${users.count},0) ;;
    value_format_name: usd
  }
}
