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

  # measure: nav_bar {
  #   type: string
  #   sql: 1 ;;
  #   html:
  #   <nav style="font-size: 18px; padding: 5px 10px 0 10px; height: 60px">
  #     <a style="padding: 5px; border-top: solid 1px #4285F4; border-left: solid 1px #4285F4; border-right: solid 1px #4285F4; border-radius: 5px 5px 0 0; float: left; line-height: 40px; font-weight: bold;" href="/dashboards-next/1171?Brand={{ _filters['my_view.field_name'] | url_encode }}">
  #   Home</a>
  #     <a style="padding: 5px; border-bottom: solid 1px #4285F4; float: left; line-height: 40px;" href="/dashboards-next/972?Brand={{ _filters['my_view.field_name'] | url_encode }}">Sportsbook</a>
  #   </nav>
  #       ;;
  # }

#   dimension: overview_button {
#     type: string
#     sql: ${id} ;;
#     label: "Overview Button"
#     html: <div style="margin: auto; ">

# <a style="
#   color: #fff;
#     background-color: #4285F4;
#     border-color: #4285F4;
#     float: left;
#     font-weight: 400;
#     text-align: center;
#     vertical-align: middle;
#     cursor: pointer;
#     user-select: none;
#     padding: 10px;
#     margin: 5px;
#     font-size: 1rem;
#     line-height: 1.5;
#     border-radius: 5px;"
#     href="/embed/dashboards-next/5?Brand={{_filters['products.brand']}}">

#     Refresh Data

# </a>
# </div>
# ;;
#   }


  # dimension: report_buttons {
  #   hidden: no
  #   type: string
  #   sql: ${id} ;;
  #   html:
  #     <!-- verbose inline css award winner 2020 -->

  #   <div style="margin: auto; ">

  #   <a style="
  #     color: #fff;
  #       background-color: #4285F4;
  #       border-color: #4285F4;
  #       float: left;
  #       font-weight: 400;
  #       text-align: center;
  #       vertical-align: middle;
  #       cursor: pointer;
  #       user-select: none;
  #       padding: 10px;
  #       margin: 5px;
  #       font-size: 1rem;
  #       line-height: 1.5;
  #       border-radius: 5px;"
  #       href="/dashboards-next/7?Brand={{_filters['products.brand']}}&Created+Date={{_filters['order_items.created_date']}}">
  #       Overview
  #   </a>
  #   <a style="
  #     color: #fff;
  #       background-color: #EA4335;
  #       border-color: #EA4335;
  #       float: left;
  #       font-weight: 400;
  #       text-align: center;
  #       vertical-align: middle;
  #       cursor: pointer;
  #       user-select: none;
  #       padding: 10px;
  #       margin: 5px;
  #       font-size: 1rem;
  #       line-height: 1.5;
  #       border-radius: 5px;"
  #       href="/dashboards-next/8?Brand={{_filters['products.brand']}}">
  #       Brand
  #   </a>



  #   <a style="
  #     color: #fff;
  #       background-color: #FBBC04;
  #       border-color: #FBBC04;
  #       float: left;
  #       font-weight: 400;
  #       text-align: center;
  #       vertical-align: middle;
  #       cursor: pointer;
  #       user-select: none;
  #       padding: 10px;
  #       margin: 5px;
  #       font-size: 1rem;
  #       line-height: 1.5;
  #       border-radius: 5px;"
  #       href="/dashboards-next/9?Brand={{_filters['inventory_items.brand']}}&Created+Date={{_filters['inventory_items.created_date']}}">
  #       Inventory!
  #   </a>
  #   </div>
  #     ;;
  # }

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
