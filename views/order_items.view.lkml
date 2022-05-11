<<<<<<< HEAD
# The name of this view in Looker is "Order Items"
view: order_items {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `thelook.order_items`
    ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

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
    datatype: date
    sql: ${TABLE}.delivered_at ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Inventory Item ID" in Explore.

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
    datatype: date
    sql: ${TABLE}.shipped_at ;;
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

  # A measure is a field that uses a SQL aggregate function. Here are count, sum, and average
  # measures for numeric dimensions, but you can also add measures of many different types.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # These sum and average measures are hidden by default.
  # If you want them to show up in your explore, remove hidden: yes.

  measure: total_sale_price {
    type: sum
    hidden: yes
    sql: ${sale_price} ;;
  }

  measure: average_sale_price {
    type: average
    hidden: yes
    sql: ${sale_price} ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.last_name,
      users.id,
      users.first_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }
=======
include: "system_fields.view"
include: "/value_formats.explore.lkml"
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
      day_of_week,
      day_of_week_index,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }


  dimension: monday {
    label: "Monday"
    type: string
    sql: CASE WHEN ${created_day_of_week_index} = 0 then 'Monday' ELSE NULL END ;;
  }

  dimension: day_of_week {
    label: "Day of Week"
    type: string
    sql:
    CASE
    when ${created_day_of_week_index} = 0 THEN '{{ _localization['Monday']}}'
    when ${created_day_of_week_index} = 1 THEN '{{ _localization['Tuesday']}}'
    when ${created_day_of_week_index} = 2 THEN '{{ _localization['Wednesday']}}'
    when ${created_day_of_week_index} = 3 THEN '{{ _localization['Thursday']}}'
    when ${created_day_of_week_index} = 4 THEN '{{ _localization['Friday']}}'
    when ${created_day_of_week_index} = 5 THEN '{{ _localization['Saturday']}}'
    when ${created_day_of_week_index} = 6 THEN '{{ _localization['Sunday']}}'
    ELSE 'OTHER' END
    ;;
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
#     href="/dashboards-next/5?Brand={{_filters['products.brand']}}">

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
    value_format_name: large_number
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
  #   html:
  #   {% if value > 0.5 %}
  #   {% assign indicator = "green,▲" | split: ',' %}
  #   {% elsif value < 0.5 %}
  #   {% assign indicator = "red,▼" | split: ',' %}
  #   {% else %}
  #   {% assign indicator = "black,▬"] | split: ',' %}
  # {% endif %}

  # <font color="{{indicator[0]}}">

  # {% if value == 99999.12345 %} &infin

  # {% else %}{{rendered_value}}

  # {% endif %} {{indicator[1]}}

  # </font> ;;
  }

  measure: cancellation_rate {
    type: number
    sql: 1.00*${count_of_cancellations}/nullif(${count},0) ;;
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

>>>>>>> branch 'dev-david-ward-f4mk' of git@github.com:DaveWard-looker/fashionly.git
}
