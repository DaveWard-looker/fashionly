view: system_fields {
  extension: required

  dimension: id {
    hidden: yes
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      date,
      day_of_week,
      week,
      month,
      year,
      month_num
    ]
  }

  # dimension: maxMonth {
  #   type: yesno
  #   sql: max(${created_month_num}) ;;
  # }



  dimension: user_id {
    hidden: yes
    }

  dimension: distribution_center_id {
    hidden: yes
    }

  dimension: inventory_item_id {
    hidden: yes
    }

  dimension: product_distribution_center_id {
    hidden: yes
    }

  dimension: product_id {
    hidden: yes
  }

  dimension: session_id {
    hidden: yes
    }

  dimension: order_id  {
    hidden: yes
  }

  dimension: latitude {
    hidden: yes
    }

  dimension: longitude {
    hidden: yes
  }

  dimension: location {
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

}
