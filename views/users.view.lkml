include: "system_fields.view"
view: users {
  extends: [system_fields]
  sql_table_name: `thelook.users`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    hidden: yes
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_group {
    type: tier
    tiers: [18,35,50,65,80]
    sql: ${age} ;;
  }

  dimension: city {
    group_label: "Address Information"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    group_label: "Address Information"
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
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

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    hidden: yes
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {

    hidden: yes
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: customer_name {
    type: string
    sql: ${first_name}||' '||${last_name} ;;
    link: {
      label: "Email {{value}}"
      url: "mailto:{{email._value}}?subject=Mr {{ last_name._value }} this offer is just for you&body=Hi {{ first_name._value }},\Thanks for signing up,\  Lets discuss some offers"
    }
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: state {
    group_label: "Address Information"
    type: string
    sql: ${TABLE}.state ;;
    map_layer_name: us_states
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    group_label: "Address Information"
    type: zipcode
    sql: ${TABLE}.zip ;;
    map_layer_name: us_zipcode_tabulation_areas
  }

  dimension: location {
    group_label: "Address Information"
    label: "User Location"
  }

  # dimension: delivery_distance {
  #   # hidden: yes
  #   type: distance
  #   start_location_field: distribution_centers.location
  #   end_location_field: users.location
  #   units: kilometers
  # }

  # dimension: delivery_distance_tier {
  #   type: tier
  #   tiers: [50,500,1000,2000,3000,4000,5000]
  #   sql: ${delivery_distance} ;;
  #   style: integer
  # }

  # measure: average_delivery_distance {
  #   type: average
  #   sql: ${delivery_distance} ;;
  #   value_format_name: decimal_0
  # }


  measure: count {
    type: count
    drill_fields: [id, last_name, first_name, events.count, order_items.count]
  }

  measure: count_of_female_users {
    type: count
    filters: [gender: "Female"]
  }

  measure: count_of_male_users {
    type: count
    filters: [gender: "Male"]
  }

  measure: average_Age {
    type: average
    sql: ${age} ;;
  }
}
