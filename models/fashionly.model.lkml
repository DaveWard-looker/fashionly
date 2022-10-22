connection: "@{connection_name}"
include: "/value_formats.explore.lkml"
include: "/dashboards/inventory_items.dashboard.lookml"

# include all the views
include: "/views/**/*"

datagroup: order_items_datagroup {
  sql_trigger: SELECT max(id) FROM order_items ;;
  max_cache_age: "24 hours"
}

datagroup: no_cache {
  max_cache_age: "0 hours"
}

datagroup: inventory_items_datagroup {
  sql_trigger: select current_date() ;;
  max_cache_age: "24 hours"
}

persist_with: order_items_datagroup


explore: dt_users_per_shipping {}

explore: order_items {
  # persist_with: no_cache
  join: dt_client {
    sql_on: ${order_items.user_id} = ${dt_client.user_id} ;;
    relationship: many_to_one
  }
}


explore: events {
  join: users {

    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}


explore: events_ireland {
  from: events
  sql_always_where: ${country} = 'Ireland' ;;
  sql_always_having: ${users.count} > 5  ;;
  join: users {

    type: left_outer
    sql_on: ${events_ireland.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}



explore: inventory_items {

  hidden: yes
  persist_with: inventory_items_datagroup
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }

}

explore: orders {
  view_name: order_items
  from: order_items
  # access_filter: {
  #   field: users.country
  #   user_attribute: manager_country
  # }
  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${inventory_items.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
  join: user_orders_fact {
    type: left_outer
    sql_on: ${order_items.user_id} = ${user_orders_fact.id} ;;
    relationship: many_to_one
  }
}

explore: products {

  join: distribution_centers {

    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items_marketing {
  hidden: no
  label: "Inventory Items Marketing"
  description: "This is marketing specific inventory items view."
  extends: [inventory_items]
  from: inventory_items
  view_name: inventory_items
  join: customers {
    sql_on: ${customers.product_id} = ${products.id} ;;
    type: left_outer
    relationship: many_to_one
  }
}





# aggregate awareness code


# Place in `fashionly` model
explore: +events {
  aggregate_table: rollup__users_age_group__users_customer_name__users_gender {
    query: {
      dimensions: [users.age_group, users.customer_name, users.gender]
      measures: [users.count]
      timezone: "UTC"
    }

    materialization: {
      datagroup_trigger: order_items_datagroup
    }
  }
}





# Place in `fashionly` model
explore: +inventory_items {
  aggregate_table: rollup__products_total_cost__products_total_price__products_total_profit__0 {
    query: {
      measures: [products.total_cost, products.total_price, products.total_profit]
      filters: [
        # "inventory_items.created_date" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        inventory_items.created_date: "this year to second",
        # "inventory_items.sold_at_timeframe" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        inventory_items.sold_at_timeframe: "day"
      ]
    }

    materialization: {
      datagroup_trigger: inventory_items_datagroup
    }
  }

  aggregate_table: rollup__products_total_cost__products_total_price__products_total_profit__1 {
    query: {
      measures: [products.total_cost, products.total_price, products.total_profit]
      filters: [
        # "inventory_items.created_date" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        inventory_items.created_date: "this year to second",
        # "inventory_items.sold_at_timeframe" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        inventory_items.sold_at_timeframe: "day"
      ]
    }

    materialization: {
      datagroup_trigger: inventory_items_datagroup
    }
  }

  aggregate_table: rollup__products_total_cost__products_total_price__products_total_profit__2 {
    query: {
      measures: [products.total_cost, products.total_price, products.total_profit]
      filters: [
        # "inventory_items.created_date" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        inventory_items.created_date: "this year to second",
        # "inventory_items.sold_at_timeframe" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        inventory_items.sold_at_timeframe: "day"
      ]
    }

    materialization: {
      datagroup_trigger: inventory_items_datagroup
    }
  }

  aggregate_table: rollup__created_date__product_category__products_department__products_name__3 {
    query: {
      dimensions: [created_date, product_category, products.department, products.name]
      measures: [average_product_retail_price]
      filters: [inventory_items.sold_at_timeframe: "day"]
    }

    materialization: {
      datagroup_trigger: inventory_items_datagroup
    }
  }

  aggregate_table: rollup__distribution_centers_count__4 {
    query: {
      measures: [distribution_centers.count]
      filters: [
        # "inventory_items.created_date" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        inventory_items.created_date: "this year to second",
        # "inventory_items.sold_at_timeframe" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        inventory_items.sold_at_timeframe: "day"
      ]
    }

    materialization: {
      datagroup_trigger: inventory_items_datagroup
    }
  }

  aggregate_table: rollup__products_brand__5 {
    query: {
      dimensions: [products.brand]
      measures: [products.count]
      filters: [
        # "inventory_items.created_date" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        inventory_items.created_date: "this year to second",
        # "inventory_items.sold_at_timeframe" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        inventory_items.sold_at_timeframe: "day"
      ]
    }

    materialization: {
      datagroup_trigger: inventory_items_datagroup
    }
  }

  aggregate_table: rollup__products_category__6 {
    query: {
      dimensions: [products.category]
      measures: [products.count]
      filters: [
        # "inventory_items.created_date" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        inventory_items.created_date: "this year to second",
        # "inventory_items.sold_at_timeframe" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        inventory_items.sold_at_timeframe: "day"
      ]
    }

    materialization: {
      datagroup_trigger: inventory_items_datagroup
    }
  }

  aggregate_table: rollup__created_date__product_category__product_name__products_department__products_name__7 {
    query: {
      dimensions: [created_date, product_category, product_name, products.department, products.name]
      measures: [count]
      filters: [inventory_items.sold_at_timeframe: "day"]
    }

    materialization: {
      datagroup_trigger: inventory_items_datagroup
    }
  }

  aggregate_table: rollup__created_date__product_category__product_department__products_department__products_name__8 {
    query: {
      dimensions: [created_date, product_category, product_department, products.department, products.name]
      measures: [count]
      filters: [inventory_items.sold_at_timeframe: "day"]
    }

    materialization: {
      datagroup_trigger: inventory_items_datagroup
    }
  }

  aggregate_table: rollup__created_date__product_category__products_department__products_name__timeframe__9 {
    query: {
      dimensions: [created_date, product_category, products.department, products.name, timeframe]
      measures: [count]
      filters: [
        inventory_items.sold_at_timeframe: "day",
        inventory_items.timeframe: "-NULL"
      ]
    }

    materialization: {
      datagroup_trigger: inventory_items_datagroup
    }
  }

  aggregate_table: rollup__products_count__10 {
    query: {
      measures: [products.count]
      filters: [
        # "inventory_items.created_date" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        inventory_items.created_date: "this year to second",
        # "inventory_items.sold_at_timeframe" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        inventory_items.sold_at_timeframe: "day"
      ]
    }

    materialization: {
      datagroup_trigger: inventory_items_datagroup
    }
  }
}
