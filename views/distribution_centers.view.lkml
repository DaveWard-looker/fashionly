include: "system_fields.view"
view: distribution_centers {
  extends: [system_fields]
  sql_table_name: `thelook.distribution_centers`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: cast(${TABLE}.id as string) ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: location {
    label: "Distribution Centre Location"
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, products.count]
  }

}
