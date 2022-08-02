view: inventory_items_by_year {
  derived_table: {
    sql: select
      PRODUCT_ID,
      PRODUCT_CATEGORY,
      PRODUCT_BRAND,
      PRODUCT_DEPARTMENT,
      PRODUCT_NAME,
      PRODUCT_SKU,
      PRODUCT_DISTRIBUTION_CENTER_ID,
      DATE_TRUNC(CREATED_AT,YEAR) AS CREATED_AT,
      DATE_TRUNC(SOLD_AT,YEAR) as SOLD_AT,
      SUM(COST) as COST,
      SUM(PRODUCT_RETAIL_PRICE) as PRODUCT_RETAIL_PRICE
      from thelook.inventory_items
      group by
      1,2,3,4,5,6,7,8,9
       ;;
      # datagroup_trigger: inventory_items_datagroup

  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: product_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.PRODUCT_ID ;;
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}.PRODUCT_CATEGORY ;;
  }

  dimension: product_brand {
    type: string
    sql: ${TABLE}.PRODUCT_BRAND ;;
  }

  dimension: product_department {
    type: string
    sql: ${TABLE}.PRODUCT_DEPARTMENT ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.PRODUCT_NAME ;;
  }

  dimension: product_sku {
    type: string
    sql: ${TABLE}.PRODUCT_SKU ;;
  }

  dimension: product_distribution_center_id {
    type: number
    sql: ${TABLE}.PRODUCT_DISTRIBUTION_CENTER_ID ;;
  }

  dimension: created_at {
    type: date
    datatype: date
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension_group: sold_at {
    type: time
    sql: ${TABLE}.SOLD_AT ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.COST ;;
  }

  dimension: product_retail_price {
    type: number
    sql: ${TABLE}.PRODUCT_RETAIL_PRICE ;;
  }

  set: detail {
    fields: [
      product_id,
      product_category,
      product_brand,
      product_department,
      product_name,
      product_sku,
      product_distribution_center_id,
      created_at,
      sold_at_time,
      cost,
      product_retail_price
    ]
  }
}
