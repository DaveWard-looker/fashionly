view: fact_order {
  derived_table: {
    sql: SELECT ORDER_ID,STATUS,SUM(SALE_PRICE) FROM `daveward-ps-dev.daveward_demodataset.order_items` group by 1,2
      ;;
      datagroup_trigger: order_items_datagroup
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: order_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ORDER_ID ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.STATUS ;;
  }

  dimension: f0_ {
    type: number
    sql: ${TABLE}.f0_ ;;
  }

  set: detail {
    fields: [order_id, status, f0_]
  }
}
