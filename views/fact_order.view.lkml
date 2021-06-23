view: fact_order {
  derived_table: {
    sql: SELECT ORDER_ID, USER_ID, SUM(SALE_PRICE) Sales FROM `daveward-ps-dev.daveward_demodataset.order_items` group by 1,2
      ;;
      persist_for: "1 minute"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.ORDER_ID ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.USER_ID ;;
  }

  dimension: sales {
    type: number
    sql: ${TABLE}.Sales ;;
  }

  set: detail {
    fields: [order_id, user_id, sales]
  }
}
