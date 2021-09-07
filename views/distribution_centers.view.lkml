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

  # dimension: report_buttons {
  #   hidden: yes
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

  #   </a>
  #   Recency Date: {{ refresh_date._rendered_value }}
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
    type: count
    drill_fields: [id, name, products.count]
  }

}
