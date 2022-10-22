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

  dimension: brandlink {
    hidden: yes
    type: string
    sql: regexp_replace(${TABLE}.BRAND , '[^a-zA-Z0-9]', '') ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.BRAND ;;
    html:{{value}} <img src = "http://www.google.com/s2/favicons?domain={{brandlink._value}}.com" /> ;;
    link: {
      label: "Google search for {{value}}"
      url: "https://www.google.com/search?q={{value}}"
      icon_url: "https://www.google.com/favicon.ico"
    }
    link: {
      label: "{{value}} Dashboard"
      url: "/dashboards/3?Brand%20Name={{value}}"
      icon_url: "https://www.google.com/s2/favicons?domain=looker.com"
    }
    link: {
      label: "{{value}} website"
      url: "http://www.{{brandlink._rendered_value}}.com"
      icon_url: "http://www.google.com/s2/favicons?domain={{brandlink._value}}.com"
    }
    link: {
      label: "{{value}} Facebook Page"
      url: "https://www.facebook.com/{{brandlink._value}}"
      icon_url: "https://www.google.com/s2/favicons?domain=facebook.com"
    }
    action: {
      label: "Send a query to the Marketing Team about {{ value }}"
      icon_url: "http://www.google.com/s2/favicons?domain={{brandlink._value}}.com"
      url: "https://fashionlydw.free.beeceptor.com"
      param: {
        name: "Message Query about this brand"
        value: "Hi I would like to make a query about {{ value }}  "
      }
    }
  }

  dimension: brand_name {
    type: string
    sql: ${brand} ;;
  }

  dimension: brand_logo {
    type: string
    sql: ${brandlink} ;;
    html: <img src="https://logo-core.clearbit.com/{{value}}.com" /> ;;
    link: {
      label: "{{value}} website"
      url: "http://www.{{brandlink._rendered_value}}.com"
      icon_url: "http://www.google.com/s2/favicons?domain={{brandlink._value}}.com   "
    }
    link: {
      label: "{{value}} Facebook Page"
      url: "https://www.facebook.com/{{brandlink._value}}/"
      icon_url: "https://www.google.com/s2/favicons?domain=facebook.com"
    }
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
  #       href="/dashboards-next/7?Brand={{ _filters['products.brand'] }}&Created+Date={{ _filters['order_items.created_date'] }}">
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
  #       href="/dashboards-next/8?Brand={{ _filters['products.brand'] }}">
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
  #       href="/dashboards-next/9?Brand={{ _filters['inventory_items.brand'] }}&Created+Date={{ _filters['inventory_items.created_date'] }}">
  #       Inventory!
  #   </a>
  #   </div>
  #     ;;
  # }


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
    drill_fields: [products.product_category,products.product_brand,total_profit,total_cost]
  }

  # measure: profit_per_customer {
  #   type: number
  #   sql: ${total_profit}/nullif(${users.count},0) ;;
  #   value_format_name: usd
  # }
}
